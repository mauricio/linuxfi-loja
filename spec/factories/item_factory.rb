
Factory.define :item do |f|
  f.quantidade 5
  f.association :produto, :factory => :produto
  f.association :pedido,  :factory => :pedido
end