class LoginController < ApplicationController

	#Declaración de constantes
	True ='TRUE'
	False='FALSE'
	Error='ERROR'


	def principal
	end
	def show
	end
	def read_parameters
		#Este método precarga el usuario y login en las variables de la clase User que es la
		#encargada de gestionar las operaciones relacionadas con el cliente
		if validFormat() then

			@usuario=Users.new(params[:user], params[:pass])
			existe = exist()
			@password = existe
		else
			if !@uservalid then
				@password = "user no valido"
			end
			if !@passvalid then
				@password = "pass no valid"
			end 
		end 

	end

	private

	def validFormat()

		#Comprobaciones formato válido usuario

		usertest = Strings.new(params[:user])
		if (!Strings.isNull(usertest.str)) && (!Strings.isEmpty(usertest.str)) && (Strings.isValidlength(usertest.str))  then
			@uservalid = true
			if Strings.isMail(usertest.str) then
				@uservalid = Strings.isValidmailformat(usertest.str)
			else
				@uservalid = (Strings.isAlphanumericformat(usertest.str))
			end 
		else
			@uservalid = false
		end
		
		#Comprobaciones formato válido contraseña

		passtest = Strings.new(params[:pass])

		@passvalid = (!Strings.isNull(passtest.str)) && (!Strings.isEmpty(passtest.str)) && (Strings.isValidlength(passtest.str))

		
		return (@uservalid && @passvalid)
		
		
	end 


	def exist()
		#Comprueba si el usuario está en BBDD
		existe=Users.isRegistred(@usuario.user, @usuario.pass)
		return existe
	end
end
