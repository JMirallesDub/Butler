module Authenticable

#Sobreescribe los métodos de Devise

	def current_user
		#Obtine el usuario activo que será aquel cuyo token conincida con el dado
		currentuser ||= User.find_by(auth_token: request.env['HTTP_AUTHORIZATION'])

	end 

	def authenticate_with_token!
		#Comprueba si el usuario está autorizado o no, lo estará si el token enviado coincide con el suyo
			render json: { errors: I18n.t(:not_authenticated) }, status: :unauthorized unless current_user.present?
	end

	def user_signed_in?
		#Este método devulve true si existe usuario activo y false en otro caso
		return current_user.present?
	end

end