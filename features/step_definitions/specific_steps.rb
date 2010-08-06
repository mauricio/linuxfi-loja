Quando /^adiciono "([^\"]*)" itens do produto "([^\"]*)" ao carrinho$/ do |quantidade, nome|
  produto = Produto.find_by_nome( nome )
  Quando "preencho \"quantidade\" com \"#{quantidade}\" em \"#produto_#{produto.id}\""
  Quando "pressiono \"Adicionar\" em \"#produto_#{produto.id}\""
end

Quando /^removo o produto "([^"]*)" do carrinho$/ do |nome|
  produto = Produto.find_by_nome( nome )
  Quando "clico em \"Remover produto\" em \"#produto_#{produto.id}\""
end

Quando /^espero (.+) segund(?:o|os)$/ do |segundos|
  sleep( segundos.to_i )
end