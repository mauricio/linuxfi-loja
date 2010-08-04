require( File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) ) )

describe SessoesController do

  context 'em chamadas pra se fazer o login do usuario' do

    before do
      @usuario = Factory(:usuario, :senha => "123456", :senha_confirmation => '123456')
    end

    def do_post( senha, email = @usuario.email )
      post :create, :email => email, :senha => senha
    end

    context 'com dados corretos' do

      it 'deve colocar o usuario na sessao' do
        do_post( '123456' )
        session[:usuario_id].should == @usuario.id
      end

      it 'deve redirecionar para a listagem de produtos' do
        do_post( '123456' )
        response.should redirect_to( produtos_path )
      end

      it 'deve colocar uma mensagem na flash' do
        do_post('123456')
        flash[:aviso].should == "Seja bem vindo a nossa loja, #{@usuario.nome}"
      end

    end

    context 'com dados incorretos' do

      it 'deve mostrar a página new' do
        do_post( 'falso!' )
        response.should render_template(:new)
      end

      it 'deve colocar uma mensagem na flash' do
        do_post('falso!')
        response.flash[:erro].should == "Não foi encontrado um usuário com o email e a senha que você forneceu"
      end

    end

    context 'ao destruir sessões' do

      before do
        controller.stub!(:reset_session)
      end

      def do_delete
        delete :destroy
      end

      it 'deve resetar a sessão' do
        controller.should_receive(:reset_session)
        do_delete
      end

      it 'deve redirecionar para a página de login' do
        do_delete
        response.should redirect_to( sessao_path )
      end

    end

  end

end
