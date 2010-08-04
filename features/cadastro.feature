# language: pt
Funcionalidade: Cadastrar um usuário no sistema

  Como usuário do sistema
  Eu quero ser capaz de criar uma conta no mesmo
  Para poder me identificar e fazer meus pedidos

  Cenário: Cadastro com sucesso
    Dado que estou na página de cadastro de usuário
    Quando preencho "usuario[nome]" com "Marcos Silva"
      E preencho "usuario[email]" com "marcos.silva@email.com"
      E preencho "usuario[senha]" com "123456"
      E preencho "usuario[senha_confirmation]" com "123456"
      E marco "usuario[termos_e_condicoes]"
      E pressiono "Enviar"
    Então devo ver "Dados recebidos com sucesso"
      E devo estar na listagem de produtos
