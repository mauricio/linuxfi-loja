
class Pedido < ActiveRecord::Base

  has_many :itens, :dependent => :destroy
  accepts_nested_attributes_for :itens
  after_save :remover_itens_zerados

  def adicionar_produto( produto, quantidade )
    if item = self.item_por_produto( produto )
      item.update_attributes(:quantidade => quantidade + item.quantidade)
    else
      self.itens.build( :produto_id => produto.id, :quantidade => quantidade )
    end
  end

  def preco_total
    self.itens.to_a.sum( &:preco_total )
  end

  def total_de_itens
    self.itens.to_a.sum(&:quantidade)
  end

  def blank?
    self.itens.blank?
  end

  def unir( outro_pedido )
    outro_pedido.itens.each do |item|
      self.adicionar_produto(item.produto, item.quantidade)
    end
    self.save
  end

  def item_por_produto( produto )
    self.itens.detect { |i| i.produto == produto }
  end

  protected

  def remover_itens_zerados
    itens_a_remover = []
    self.itens.each do |item|
      if item.quantidade.blank? || item.quantidade < 1
        itens_a_remover << item
      end
    end
    self.itens.delete( *itens_a_remover )
    true
  end

end