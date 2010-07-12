
class ProdutosController < ApplicationController

  def index
    @titulo   = "Listagem de Produtos"
    @produtos = Produto.all

    respond_to do |format|
      format.html do
        render :index
      end
      format.xml do
        render :xml => @produtos
      end
    end

  end

end