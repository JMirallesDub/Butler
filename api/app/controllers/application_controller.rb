class ApplicationController < ActionController::Base
  #Evita ataques CSFR - falsificación de petición en sitios cruzados
  #son peticiones vía get/post que se realizan desde el front
  #donde un sw aprovecha el inicio de sesión en la aplicación
  #para realizar el ataque


  #Conversión de la API en multilenguaje
  before_action :set_locale 

  #protect_from_forgery with: :exception

  include Authenticable

  

  def userLogged (user, pass,current_sign_in_at)
    semilla = current_sign_in_at.to_datetime
    pass_enc = Encrypts.encrypt(pass,semilla)
  	user_bd = User.where(:user => user, :password => pass_enc)
    return (!user_bd.blank?) && (user_bd[0]['logged'] == 1)
    
  end

  private

 	def set_locale

 		if params[:locale] !=nil 
 			I18n.locale = params[:locale].to_sym
 		else
 			I18n.locale = I18n.default_locale
 		end
 	end

  def currentUser
    user=Authenticable.current_user
  end
end

