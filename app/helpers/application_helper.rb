# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cabecalho_de_tabela( *nomes )
    linhas = nomes.map { |nome| "<th>#{nome}</th>" }
    content_tag( :thead, content_tag( :tr, linhas.join("\n") ) )
  end

  def render_flash
    render 'compartilhados/flash', :flash => flash
  end

end
