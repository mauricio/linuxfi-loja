
class Item < ActiveRecord::Base

  belongs_to :produto, :class_name => "Produto", :foreign_key => "produto_id"
  belongs_to :pedido

  def preco_total
    self.quantidade * self.produto.preco
  end

end