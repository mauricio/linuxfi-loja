
class SessoesController < ApplicationController

  def new
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  alias :show :new

  def create
    @usuario = Usuario.autenticar( params[:email] , params[:senha])
    if @usuario
      self.usuario_atual = @usuario
      respond_to do |format|
        format.html do
          flash[:aviso] = "Seja bem vindo a nossa loja, #{self.usuario_atual.nome}"
          redirect_to produtos_path
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:erro] = 'Não foi encontrado um usuário com o email e a senha que você forneceu'
          new
        end
      end
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html do
        flash[:aviso] = 'Você saiu da aplicação com sucesso'
        redirect_to sessao_path
      end
    end
  end

end