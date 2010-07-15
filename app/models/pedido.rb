
class Pedido < ActiveRecord::Base

  has_many :itens, :dependent => :destroy
  accepts_nested_attributes_for :itens
  after_save :remover_itens_zerados

  # def itens_attributes=( array )
  # def endereco_attributes=( array )
  #   accepts_nested_attributes_for :endereco
  #   pedido[endereco_attributes][nome]
  #   pedido[endereco_attributes][cidade]
  #   pedido[endereco_attributes][estado]
  #   pedido[endereco_attributes][pais]


  def adicionar_produto( produto, quantidade )
    if item = self.itens.detect { |i| i.produto == produto }
      item.update_attributes(:quantidade => quantidade + item.quantidade)
    else
      self.itens.build( :produto_id => produto.id, :quantidade => quantidade )
    end
  end

  def preco_total
    #self.itens.to_a.sum { |item| item.preco_total }
    self.itens.to_a.sum( &:preco_total )
  end

  def blank?
    self.itens.blank?
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