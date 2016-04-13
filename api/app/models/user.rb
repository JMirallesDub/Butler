class User < ActiveRecord::Base

	has_many :company
	has_many :branchoffice
	has_one :userdatum
	has_many :book, :dependent => :destroy

require 'encrypts'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, 
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, :uniqueness => true

  validates :email, :length => { 
  	in: 4..256,
  	too_short: I18n.t(:user_too_short),
  	too_long: I18n.t(:user_too_long)},
  	:format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i ,
   	:message => I18n.t(:user_invalid_email) },
  	:uniqueness => true
  

  validates :user, :length => {
  	in: 4..256,
  	too_short: I18n.t(:user_too_short),
  	too_long: I18n.t(:user_too_long)},
  	uniqueness: true
  


  validates :password, 
  	:length => { in: 2..256 },
  	:on => :create



  



  	
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

	def self.getUserbyemail(email)
		user_bd = User.where(:email => email)
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

	def self.getUserbyuser (user)
		#Devuelve el usuario cuyo user coincide con el user del argumento
		user_bd = User.where(:user => user)
		return user_bd
	end
	def self.cargaRegistroBasico (user_bd, parameters)
		user_bd.user = parameters["user"]
		user_bd.email = parameters["user"]
		user_bd.current_sign_in_at = (Time.now.utc.iso8601).to_datetime
		pass_encrypted = Encrypts.encrypt(parameters["pass"],(user_bd.current_sign_in_at).to_datetime)
		user_bd.password=pass_encrypted
		user_bd.auth_token = generate_authentication_token!
		return user_bd
	end

	def self.updateSession(user_bd, logged)
		user_bd.auth_token = User.generate_authentication_token!
		user_bd.updated_at = (Time.now.utc.iso8601).to_datetime
		user_bd.last_sign_in_at = (Time.now.utc.iso8601).to_datetime
		user_bd.logged = logged
		return user_bd
	end

	private

		

end
