require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe Produto do

  context 'ao ser validado' do

    it { should validate_presence_of :nome }
    it { should validate_presence_of :preco }
    it { should validate_numericality_of :preco, :allow_blank => true, :greater_than => 0 }

  end

end