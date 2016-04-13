class Notifiers < ApplicationMailer

	def forgotPass(user, mail, auth_token)
		byebug
		#Definimos los valores que serán accesibles desde el formulario incrustado en el correo
		@user = user
		@mail = mail
		@auth_token = auth_token
		@saludo = I18n.t(:reminder_greeting)
		@cuerpo_mail = I18n.t(:reminder_mail_body)
		@texto_boton = I18n.t(:submit_button_text)
		@ruta_confirmar='http://localhost:3000'
		@main= 'http://www.jeddins.com'
		@despedida=I18n.t(:reminder_password_farewell)
		subject=I18n.t(:reminder_password_subjec_mail)
		mail (:to => 'dperez@jeddins.com', :subject => subject)
		
	end

	def confirmAccount(user, mail, auth_token)
		byebug
		#Definimos los valores que serán accesibles desde el formulario incrustado en el correo
		@mail = mail
		@user = user
		@auth_token = auth_token
		@saludo = I18n.t(:confirm_account_greeting)
		@cuerpo_mail = I18n.t(:confirm_account_mail_body)
		@texto_boton = I18n.t(:submit_button_text)
		@ruta_confirmar='http://localhost:9000/confirm_account'
		@main= 'http://www.jeddins.com'
		@despedida=I18n.t(:rconfirm_account_farewell)
		byebug
		mail (:to => 'dperez@jeddins.com', :subject => I18n.t(:confirm_account_subject_mail))
		
	end

	def bookautomaticcancel(user, book)

		length = user.size
		i = 0
		@cuerpo_mail = I18n.t(:cancel_mail_body1) + (book.date).to_s + I18n.t(:cancel_mail_body2) + (book.time).to_s + I18n.t(:cancel_mail_body3)
		@saludo =I18n.t(:cancel_greting) + user.name
		@main= 'http://www.jeddins.com'
		@despedida=I18n.t(:cancel_farawell)
		while (i <= length - 1) do
			@mail = user[i]['mail']
			@user = user[i]['user']
			subject = I18n.t(:cancel_subject_mail)
			#mail (:to => 'jvazquez@jeddins.com', :subject => subject)
		end
		
	end
end

