# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  filter_parameter_logging :senha, :senha_confirmation

  helper_method :pedido_atual, :usuario_atual, :logged_in?, :administrador?

  protected

  def pedido_atual
    unless @pedido_atual
      @pedido_atual = Pedido.find_by_id( session[:pedido_id] ) unless session[:pedido_id].blank?
      if @pedido_atual.nil?
        @pedido_atual       = Pedido.new
        session[:pedido_id] = nil
      end
    end
    @pedido_atual
  end

  def load_page
    @page     = params[:page] || 1
    @per_page = params[:per_page] || 10
  end

  def paginate( scope, options = {} )
    load_page
    scope.paginate( { :page => @page, :per_page => @per_page }.merge( options ) )
  end

  def login_necessario
    unless self.logged_in?
      respond_to do |format|
        format.html do
          flash[:erro] = 'Você precisa estar logado para acessar esta página'
          redirect_to sessao_path
        end
      end
    else
      true
    end
  end

  def administrador_necessario
    unless self.administrador?
      respond_to do |format|
        format.html do
          flash[:erro] = 'Você precisa ser um administrador para visualizar esta página'
          redirect_to sessao_path
        end
      end
    else
      true
    end
  end

  def logged_in?
    self.usuario_atual
  end

  def administrador?
    logged_in? && self.usuario_atual.administrador?
  end

  def usuario_atual
    if @usuario_atual != false
      @usuario_atual = login_pela_sessao
    end
    @usuario_atual
  end

  def usuario_atual=( usuario )
    @usuario_atual = usuario
    session[:usuario_id] = usuario.id
    usuario.create_pedido_atual unless usuario.pedido_atual
    unless self.pedido_atual.blank?
      usuario.pedido_atual.unir( self.pedido_atual )
      self.pedido_atual.destroy
    end
    session[:pedido_id] = usuario.pedido_atual.id
  end

  def login_pela_sessao
    resultado = !session[:usuario_id].blank? && Usuario.find_by_id( session[:usuario_id] )
    resultado ? resultado : false
  end

end
