require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe ItensController do

  context 'em chamadas para adicionar itens ao pedido' do

    before do
      @produto = mock( Produto, :nome => "Exemplo" )
      Produto.stub!( :find ).with('2').and_return( @produto )

      @pedido  = mock( Pedido, :adicionar_produto => true, :save => true, :id => 1 )
      controller.stub(:pedido_atual).and_return( @pedido )
    end

    def do_post
      post :create, :produto_id => "2", :quantidade => '5'
    end

    it 'deve chamar para adicionar o produto ao pedido' do
      @pedido.should_receive( :adicionar_produto ).with( @produto, 5 )
      do_post
    end

    it 'deve salvar o pedido' do
      @pedido.should_receive( :save )
      do_post
    end

    it 'deve colocar o id do pedido na sessão' do
      do_post
      session[:pedido_id].should == 1
    end

    it 'deve redirecionar para o carrinho' do
      do_post
      response.should redirect_to( itens_path )
    end

  end

end