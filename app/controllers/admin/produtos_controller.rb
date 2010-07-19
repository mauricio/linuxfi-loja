
class Admin::ProdutosController < Admin::BaseController

  before_filter :load_produto, :only => [ :new, :edit, :create, :update, :destroy ]

  def index
    @produtos = paginate( Produto )
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  alias :edit :new

  def create
    if @produto.update_attributes( params[:produto] )
      ir_para_listagem( 'Produto criado/atualizado com sucesso' )
    else
      new
    end
  end

  alias :update :create

  def destroy
    @produto.destroy
    ir_para_listagem( 'Produto removido com sucesso' )
  end

  protected

  def load_produto
    @produto = params[:id].blank? ? Produto.new : Produto.find( params[:id] )
  end

  def ir_para_listagem( mensagem )
    respond_to do |format|
      format.html do
        flash[:aviso] = mensagem
        redirect_to admin_produtos_path
      end
    end
  end

end