
module Admin::ProdutosHelper

  def admin_form_for_produto( &block )
    opcoes = if @produto.new_record?
      [admin_produtos_path, :post]
    else
      [admin_produto_path( @produto ), :put]
    end
    form_for( @produto, 
      :url => opcoes.first,
      :html => { :method => opcoes.last, :multipart => true },
      &block )
  end

end