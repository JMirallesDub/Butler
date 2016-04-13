class Api::V1::UsersController < ApplicationController

	require 'notifiers_mailer'
#Hay que añadir a la cabecera del controlador la ruta ya que no 
#están en la ruta por defecto (app/controllers sino en app/controllers/api/v1)
	
	#Restringimos que el usurio que puede actualizar y borrar un registro deba estar loggeado
	before_action :authenticate_with_token!, only: [:update, :destroy]


	respond_to :json

	def show
		respond_with User.find(params[:id])
	end

	def create
		user_bd = User.new
		user_bd=User.cargaRegistroBasico(user_bd, user_params)
		if user_bd.save
			byebug
			Notifiers.confirmAccount(user_bd.user, user_bd.email, user_bd.auth_token).deliver_now
			render json: {user: user_bd.user, auth_token: user_bd.auth_token}, status: 201
		else
			render json: {errors: user_bd.errors}, status: 422
		end
	end 

	private

		def user_params
			#aplicamos filtros a los posbiles parámetros que vamos a tener
			#require(:user, password) indica que los parámetros user y password debe venir en la url, y si no viene devuelve error
			#permit(:email, :password_confiramtio) indica que de todos los parámetro (además de user, password)
			#que vengan en la url, desechará todos lo que no sean email, password_confirmation

			params.require(:users).permit(:user, :pass)
		end
end

