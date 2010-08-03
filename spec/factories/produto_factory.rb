Factory.define :produto do |f|
 f.nome      { Factory.next(:nome) }
 f.preco     10.0
 f.descricao "Descrição de exemplo"
end