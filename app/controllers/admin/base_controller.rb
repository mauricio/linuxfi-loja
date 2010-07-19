
class Admin::BaseController < ApplicationController

  layout 'administracao'

  before_filter :administrador_necessario

end