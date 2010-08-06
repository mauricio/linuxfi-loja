
class ItensController < ApplicationController
  
  def create
    @produto = Produto.find( params[:produto_id] )

    pedido_atual.adicionar_produto(@produto, params[:quantidade].to_i )
    pedido_atual.save

    session[:pedido_id] = pedido_atual.id
    ir_para_carrinho( "Produto #{@produto.nome} adicionado com sucesso ao carrinho" )
  end

  def atualizar_pedido
    pedido_atual.update_attributes( params[:pedido] )
    ir_para_carrinho( "Carrinho atualizado som sucesso" )
  end

  def destroy
    @item = pedido_atual.itens.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.js
    end
  end

  protected

  def ir_para_carrinho( mensagem )
    respond_to do |format|
      format.html do
        flash[:aviso] = mensagem
        redirect_to itens_path
      end
      format.js
    end
  end

end