
class ProdutosController < ApplicationController

  def index
    @produtos = Produto.all
    respond_to do |format|
      format.html
      format.xml do
        render :xml => @produtos
      end
    end
  end

end