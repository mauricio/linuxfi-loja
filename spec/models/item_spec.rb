require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe Item do

  context 'ao ser associado a outros objetos' do

    it { should belong_to(:pedido) }
    it { should belong_to(:produto) }

  end

  context 'ao se calcular preços' do

    before do
      @produto = Factory(:produto, :preco => 20)
      @item    = Factory( :item, :produto => @produto , :quantidade => 6 )
    end

    it 'deve ter como preço 120' do
      @item.preco_total.should == 120
    end

  end

end