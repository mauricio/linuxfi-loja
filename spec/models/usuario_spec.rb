require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe Usuario do

  context 'em associações' do

    it { should have_many(:pedidos) }
    it { should have_one(:pedido_atual) }

  end

  context 'em validações' do

    it { should validate_presence_of( :nome ) }
    it { should validate_presence_of( :email ) }
    it { should validate_acceptance_of(:termos_e_condicoes) }
    it { should validate_presence_of(:senha_em_hash, :if => :senha_necessaria?) }
    it { should validate_length_of(:senha, :within => 4..40, :if => :senha_necessaria?) }
    it { should validate_confirmation_of(:senha, :if => :senha_necessaria?) }

  end

  context 'em chamadas de senha_necessaria?' do

    before do
      @usuario = Factory(:usuario)
      @usuario.senha = nil
    end

    it 'deve retornar false quando o hash da senha não for vazio' do
      @usuario.senha_necessaria?.should be_false
    end

    it 'deve retornar true quando a senha for preenchida' do
      @usuario.senha = "123456"
      @usuario.senha_necessaria?.should be_true
    end

    it 'deve retornar true quando o hash da senha for vazio' do
      @usuario.senha_em_hash = nil
      @usuario.senha_necessaria?.should be_true
    end

  end

  context 'ao criar um usuário' do

    before do
      @usuario = Factory.build(:usuario)
    end

    it 'deve enviar um email' do
      UsuariosMailer.should_receive( :deliver_registro ).with(@usuario)
      @usuario.save!
    end

  end

  context 'em chamadas de autenticação' do

    before do
      @usuario = Factory(:usuario, 
        :senha => '123456',
        :senha_confirmation => '123456')
    end

    it 'deve autenticar o usuário se estiver com a senha correta' do
      Usuario.autenticar(@usuario.email, '123456').should == @usuario
    end

    it 'não deve autenticar se a senha estiver errada' do
      Usuario.autenticar( @usuario.email, "654321" ).should be_nil
    end

  end

end