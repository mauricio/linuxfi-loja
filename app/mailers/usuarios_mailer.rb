
class UsuariosMailer < BaseMailer

  def registro( usuario )
    defaults
    subject    "Seja bem vindo a loja virtual em Rails"
    recipients usuario.email
    body       :usuario => usuario
  end

end