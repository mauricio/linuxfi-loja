# language: pt
Funcionalidade: Fazer login do usuário

  Como usuário do sistema
  Eu quero me autenticar no mesmo
  Para poder acessar meu carrinho de compras

  Cenário: Fazer login
    Dado que o seguinte usuario existe:
      |nome           | email          | senha  | senha_confirmation |
      | José da Silva | jose@silva.com | 123456 | 123456             |
      E que estou na página de login
    Quando preencho "email" com "jose@silva.com"
      E preencho "senha" com "123456"
      E pressiono "Enviar"
    Então devo ver "Seja bem vindo a nossa loja, José da Silva"
      E devo estar na listagem de produtos