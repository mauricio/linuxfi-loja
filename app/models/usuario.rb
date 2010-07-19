class Usuario < ActiveRecord::Base

  attr_accessor :senha, :termos_e_condicoes

  has_one :pedido_atual, :class_name => 'Pedido', :conditions => { :estado => 'carrinho' }

  has_many :pedidos

  validates_presence_of     :nome, :email
  validates_acceptance_of   :termos_e_condicoes, :if => :new_record?
  validates_presence_of     :senha_em_hash, :if => :senha_necessaria?
  validates_confirmation_of :senha, :if => :senha_necessaria?
  validates_length_of       :senha, :within => 4..40, :if => :senha_necessaria?

  before_validation :hashear_senha
  after_create      :enviar_email

  def senha_necessaria?
    self.senha_em_hash.blank? || !self.senha.blank?
  end

  def senha_correta?( _senha )
    self.senha_em_hash == Usuario.hashear( _senha, self.salt )
  end

  class << self

    def hashear( senha, salt )
      Digest::SHA1.hexdigest("--#{salt}--#{senha}--")
    end

    def autenticar( email, senha )
      usuario = Usuario.first( :conditions => { :email => email } )
      if usuario && usuario.senha_correta?( senha )
        usuario
      else
        nil
      end
    end

  end

  protected

  def hashear_senha
    return true if self.senha.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s(:db)}--#{self.email}--#{self.nome}") if self.new_record?
    self.senha_em_hash = Usuario.hashear(self.senha, self.salt)
  end

  def enviar_email
    UsuariosMailer.deliver_registro( self )
  end

end