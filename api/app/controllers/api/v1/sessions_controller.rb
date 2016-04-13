class Api::V1::SessionsController < ApplicationController

	require 'time'
	require 'encrypts'
	require 'notifiers_mailer'

	respond_to :json

	before_action :userAccountAvailable , only: [:create]
	

	def create

		if !@user.blank? then
			if !userLogged(session_params['user'], session_params['pass'], @user[0]['current_sign_in_at'])then
				user_to_save=User.updateSession(@user[0], 1)
				if user_to_save.save then
					render json: {id: user_to_save.id, user: user_to_save.user, auth_token: user_to_save.auth_token}, status: 201
				else
					render json: {errors: user_to_save.errors}, status: 422
				end
			else
				render json: {id: @user[0]['id'], user: @user[0]['user'], auth_token: @user[0]['auth_token']}, status: 200
			end
		end


	end

	def destroy
		user=User.getUserbytoken(request.env['HTTP_AUTHORIZATION'])
		if !user.blank? && user[0]['logged'] == 1 then
			user_to_save=User.updateSession(user[0],0)
			if user[0].save then
				render json: {}, status: 204
			else
				render json: {errors: user_to_save.errors}, status: 422
			end
		else
			render json: {errors: I18n.t(:invalid_session)}, status: 422
		end
	end

	def forgotPassword

		user= User.getUserbyemail(session_params[:email])

		if !user.blank? then
			user[0]['auth_token'] = User.generate_authentication_token!
			if user[0].save then
				Notifiers.forgotPass(user[0]['user'], user[0]['email'], user[0]['auth_token']).deliver_now
				render json: {user: user[0]['user']}, status: 200
			else
				render json: {errors: user_to_save.errors}, status: 422
			end
		else
			render json: {}, status: 204
		end
	end


	private

		
		 

		def userAccountAvailable
		#Esta función se encarga de comprobar si la cuenta está activa para el usuario
		#La cuenta estará activa si existe un registro en BBDD para el usuario con token y fecha de ultma 
		#actualización no nulapar

  			@user=User.getUserbyuser(session_params[:user])

  			if (@user.blank?) || (@user[0]['last_sign_in_at'] == nil) then
  				render json: {errors: I18n.t(:inactive_account)} , status: 401 
  				return
			end
  		end

		def session_params
			params.require(:session).permit(:user, :pass, :auth_token, :email)
		end
		
		

end
