
class UsuariosController < ApplicationController

  before_filter :login_necessario, :only => [ :edit, :update ]
  before_filter :load_usuario

  def new
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  alias :edit :new
  alias :show :new

  def create
    @usuario.attributes = params[:usuario]
    if @usuario.save
      self.usuario_atual = @usuario unless logged_in?
      respond_to do |format|
        format.html do
          flash[:notice] = 'Dados recebidos com sucesso'
          redirect_to produtos_path
        end
      end
    else
      self.new
    end
  end

  alias :update :create

  protected

  def load_usuario
    @usuario = logged_in? ? self.usuario_atual : Usuario.new
  end

end