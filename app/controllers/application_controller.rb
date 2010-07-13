# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :pedido_atual, :usuario_atual

  protected

  def pedido_atual
    unless @pedido_atual
      @pedido_atual = session[:pedido_id].blank? ?
        Pedido.new : Pedido.find( session[:pedido_id] )
    end
    @pedido_atual
  end

end
