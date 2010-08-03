require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe Pedido do

  context 'em associações' do

    it { should have_many(:itens, :dependent => :destroy) }

  end

  context 'em operacoes' do

    before do
      @produto_1 = Factory( :produto, :preco => 10 )
      @produto_2 = Factory( :produto, :preco => 20 )
      @produto_3 = Factory( :produto, :preco => 30 )
      @pedido    = Factory( :pedido )
    end

    it 'deve ter como preço total a suma dos preços individuais dos itens' do
      @pedido.adicionar_produto( @produto_1, 2 )
      @pedido.adicionar_produto( @produto_2, 5 )
      @pedido.preco_total.should == 120
    end

    context 'na implementação de blank' do

      it 'deve retornar verdadeiro se o pedido estiver vazio' do
        @pedido.should be_blank
      end

      it 'deve retornar false se o pedido não estiver vazio' do
        @pedido.adicionar_produto( @produto_1, 3 )
        @pedido.should_not be_blank
      end

    end

    context 'ao unir pedidos' do

      before do
        @pedido.adicionar_produto( @produto_1, 2 )
        @pedido.adicionar_produto( @produto_2, 3 )

        @pedido_2 = Factory(:pedido)
        @pedido_2.adicionar_produto( @produto_2, 2 )
        @pedido_2.adicionar_produto( @produto_3, 3 )

        @pedido.unir( @pedido_2 )
      end

      it 'o pedido final deve ter o total de itens dos dois pedidos' do
        @pedido.item_por_produto( @produto_1 ).quantidade.should == 2
        @pedido.item_por_produto( @produto_2 ).quantidade.should == 5
        @pedido.item_por_produto( @produto_3 ).quantidade.should == 3
      end

    end

    context 'ao adicionar um produto ao pedido' do

      before do
        @pedido.adicionar_produto( @produto_1, 5 )
      end

      it 'deve adicionar um produto como item do pedido' do
        @pedido.itens.size.should == 1
      end

      it 'deve adicionar o produto corretamente' do
        @pedido.itens.first.produto == @produto_1
      end

      it 'deve aumentar a quantidade de itens ao adicionar o mesmo item denovo' do
        @pedido.adicionar_produto( @produto_1, 3 )
        @pedido.itens.first.quantidade.should == 8
      end

    end

    context 'deve remover itens zerados após salvar o pedido' do

      before do
        @pedido.adicionar_produto(@produto_1, 1)
        @pedido.adicionar_produto(@produto_2, 2)
        @pedido.save!
      end

      it 'deve remover o produto' do
        @pedido.itens.last.update_attribute( :quantidade, 0 )
        @pedido.save!
        @pedido.item_por_produto( @produto_2 ).should be_nil
      end

    end

  end

end