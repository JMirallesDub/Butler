class Api::V1::SessionsController < ApplicationController

	require 'strings'
	require 'time'
	require 'encrypts'
	require 'notifiers_mailer'

	before_action :userAccountAvailable , only: [:create]
	

	def create
		#if validate_params then
			#@user = User.getUserbyuser(params[:session][:user])
			#@user = User.getUser(params[:session][:user], params[:session][:pass])
			num_records = @user.size
			case num_records
				when 0
					responseNotFound()
				when 1
					if !user_logged then
						error = updateToken('C')
						if !error then
							sign_in User, store: false
							responseLogin()
						end 
					else
						 responseLogin()
					end
				else
					responseMultiUser()
			end
		#else
			#responseInvalidData()
		#end
		@prueba = 'hola'
		#if !@user.blank? && !userLogged () then
			@user.auth_token = User.generate_authentication_token!
			@user.updated_at = (Time.now.utc.iso8601).to_datetime
			@user.last_sign_in_at = (Time.now.utc.iso8601).to_datetime
			@user.logged =1
			#if @user.save then

			#else
			#end
		#end


	end

	def destroy
		token = request.env['HTTP_AUTHORIZATION']
		if user_signed_in? then
			if (token !=nil) && (token != "") then
				@user = User.getUserbytoken(token)
				num_records = @user.size
				if num_records == 1 then
					error = updateToken('D')
					if !error then
						sign_out User
						render json: {}, status: 200
					end
				else
					responseNotFound()
				end
			else
				responseInvalidData()
			end
		else
			responseInvalidSession()
		end 
	end

	def forgotPassword
		usertest = Strings.new(params[:session][:user])
		@uservalid= validateUser(usertest)
		if @uservalid then
			@user = User.getUserbyuser(params[:session][:user])
			num_records = @user.size
			if num_records == 1 then
				#error = updateToken('D') 
				#if !error then
					#Llamada a envío de mail
					Notifiers.forgotPass(@user[0]['user'], @user[0]['email']).deliver_now
					render json: {user: @user[0]['user']}, status: 200
				#end
			else
				responseNotFound()
			end
		else
			responseInvalidData()
		end
	end


	private

		def validate_params

			usertest = Strings.new(params[:session][:user])
			@uservalid= validateUser(usertest)
			#if (!Strings.isNull(usertest.str)) && (!Strings.isEmpty(usertest.str)) && (Strings.isValidlength(usertest.str))  then
			#	@uservalid = true
			#	if Strings.isMail(usertest.str) then
			#		@uservalid = Strings.isValidmailformat(usertest.str)
			#	else
			#		@uservalid = (Strings.isAlphanumericformat(usertest.str))
			#	end 
			#else
			#	@uservalid = false
			#end

			#Comprobaciones formato válido contraseña

			passtest = Strings.new(params[:session][:pass])

			@passvalid = (!Strings.isNull(passtest.str)) && (!Strings.isEmpty(passtest.str)) && (Strings.isValidlength(passtest.str))

			if @passvalid then
				@user = User.getUserbyuser(params[:session][:user])
				num_records = @user.size
				if num_records == 1 then
					data_to_encrypt = Encrypts.new(params[:session][:pass], ((@user[0]['created_at']).to_time).to_s)
					pass_encrypted = Encrypts.encrypt(data_to_encrypt.str,data_to_encrypt.seek)
					if pass_encrypted != @user[0]['password'] then
						@passvalid = false
					end
				end
			end 
		
			return (@uservalid && @passvalid)
		
		end

		def validateUser (usertest)
			if (!Strings.isNull(usertest.str)) && (!Strings.isEmpty(usertest.str)) && (Strings.isValidlength(usertest.str))  then
				uservalid = true
				if Strings.isMail(usertest.str) then
					uservalid = Strings.isValidmailformat(usertest.str)
				else
					uservalid = (Strings.isAlphanumericformat(usertest.str))
				end 
			else
				uservalid = false
			end
			return uservalid
		end 

		def updateToken (action)
		#Esta función se encarga de actualizar el token en BBDD
		#Si estamos iniciando sesión (action = C ) activamos el flag logged; en otro caso lo desactivamos
			error = false
			auth_token = User.generate_authentication_token!
			if auth_token != nil then
				@user[0]['auth_token'] = auth_token
				@user[0]["updated_at"] = (Time.now.utc.iso8601).to_datetime
				@user[0]['last_sign_in_at'] = (Time.now.utc.iso8601).to_datetime
				if action == 'C' then
					@user[0]['logged']= 1
				else
					@user[0]['logged']=0
				end 
				@user[0].save
				if @user[0].errors.count() > 0 then
					render json: { errors: @user[0].errors.messages} , status: 422
					error = true
				end 
			end
			return error

		end  

		def userAccountAvailable
		#Esta función se encarga de comprobar si la cuenta está activa para el usuario
		#La cuenta estará activa si existe un registro en BBDD para el usuario con token y fecha de ultma 
		#actualización no nula
  			@user=User.getUserbytoken(request.env['HTTP_AUTHORIZATION'])
  			return (@user.upadte_at !=nil)
  		end
		
		def responseNotFound
			render json: { errors: I18n.t(:login_user_notfound) }, status: 404
		end

		def responseMultiUser
			render json: { errors: I18n.t(:login_multi_user) }, status: 409
		end
		def responseInvalidData
			render json: { errors: I18n.t(:invalid_data) }, status: 404
		end
		def responseInvalidSession
			render json: { errors: I18n.t(:invalid_session) }, status: 404
		end
		def responseLogin
			render json: {user: @user[0]['user'], auth_token: @user[0]['auth_token'], email: @user[0]['email'], logged: @user[0]['logged']}, status: 200
		end

		

end
