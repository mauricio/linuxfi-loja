
class Produto < ActiveRecord::Base

  validates_presence_of :nome, :preco
  validates_numericality_of :preco, :greater_than => 0, :allow_nil => true

end