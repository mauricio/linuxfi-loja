class CriarProdutos < ActiveRecord::Migration
  def self.up

    create_table :produtos do |t|
      t.string  :nome, :null => false
      t.text    :descricao
      t.decimal :preco, :precision => 10, :scale => 2, :null => false
      t.timestamps
    end

  end

  def self.down

    drop_table :produtos

  end
end
