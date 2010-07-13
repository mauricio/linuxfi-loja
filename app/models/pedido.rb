
class Pedido < ActiveRecord::Base

  has_many :itens

  def adicionar_produto( produto, quantidade )
    if item = self.itens.detect { |i| i.produto == produto }
      item.update_attributes(:quantidade => quantidade + item.quantidade)
    else
      self.itens.build( :produto_id => produto.id, :quantidade => quantidade )
    end
  end

end