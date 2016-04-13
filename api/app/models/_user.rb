class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	#Validaciones


	validates :user, uniqueness: true, 

  validates :auth_token, uniqueness: true

  before_create :generate_authentication_token!


  

	def self.getUser (user, pass)
		#Comprueba si el usuario está en BBDD; si no está devolverá 0 filas; si está y devuelve
		#más de una fila existe un error en los datos; en otro caso todo correcto
		 user_bd = User.where(:user => user, :password => pass)
		 return user_bd
	end 

	def self.getUserbytoken (token)
		#Devuelve el usuario cuyo auth_token coincide con el token del argumento
		user_bd = User.where(:auth_token => token)
		return user_bd
	end 

	def self.generate_authentication_token!
		#Genera el token 
		#Genera el token con la llamada a Devise.friendly_toke
		#comprueba si ya existe el token en el modelo, y si existe lo regenera hasta que gener uno que no exista
		begin
			auth_token = Devise.friendly_token
		end while self.exists?(auth_token: auth_token)
		return auth_token
	end 
