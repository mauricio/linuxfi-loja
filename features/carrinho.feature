# language: pt
@javascript
Funcionalidade: Adicionar e remover itens do carrinho

  Como usuário do sistema
  Eu quero adicionar e remover itens ao carrinho
  Para ser capaz efetuar compras

  Contexto:
    Dado que os seguintes produtos existem:
      | nome                          | preco |
      | Agile Estimating and Planning | 30.00 |
      | Lean Software Development     | 25.00 |

  Cenário: Adicionar item ao carrinho
    Dado que estou na listagem de produtos
    Quando adiciono "5" itens do produto "Lean Software Development" ao carrinho
    Então devo ver "Lean Software Development - 5"

  Cenário: Remover itens do carrinho
    Dado que estou na listagem de produtos
      E adiciono "5" itens do produto "Lean Software Development" ao carrinho
      E adiciono "5" itens do produto "Agile Estimating and Planning" ao carrinho
    Quando vou pra página do carrinho
      E removo o produto "Agile Estimating and Planning" do carrinho
    Entao devo ver "Lean Software Development"
      Mas não devo ver "Agile Estimating and Planning"