module NavigationHelpers

  def path_to(page_name)
    case page_name
    when /página inicial/
      '/'
    when 'listagem de produtos'
      produtos_path
    when 'página do carrinho'
      itens_path
    when /página de (.*)/
      case $1
      when 'login'
        sessao_path
      when 'cadastro de usuário'
        new_usuario_path
      else
        raise_path_error( $1 )
      end
    else
      raise_path_error( page_name )
    end
  end

  def raise_path_error( path )
      raise "Can't find mapping from \"#{path}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end

end

World(NavigationHelpers)
