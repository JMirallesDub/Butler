class Strings

	#isEmpty(cadena) -> Devuelve true si cadena es la cadena vacía
	#isMail(cadena) -> Devuelve true si la cadena es un mail. La cadena se considerará que 
	#                  es un mail si contiene el carácter @. Para saber si el formato es válid
	#                  se llamará a la función isMailRight
	#isNull(cadena) -> Devuelve true si la cadena es nula
	#isValidlength (cadena) -> Devuelve true si la longitud de la cadena está entre 2 y 256
	#isAlphanumericformat(cadena)-> Devuelve true si la cadena sólo contiene letras y números
	#isValidmailformat(cadena)->Devuelve true si el formato de mail introducido es válido


	attr_accessor :str

	True="TRUE"
	False="FALSE"
	Error="ERROR"
	Maxlength=256
	Minlength=2

	def initialize (cadena)
		@str = cadena
	end
	
	def self.isEmpty(cadena)
		
		if (cadena == ' ') || (cadena.length == 0) then
			return true
		else
			return false
		end 
		
	end

	def self.isMail(cadena)
		
		if cadena.include? "@" then

			return true
		else
			return false
		end
		
	end 

	def self.isNull(cadena)
		
		if cadena == nil then
			return true
		else
			return false
		end
		
	end 

	def self.isValidlength (cadena)
		
		if cadena.length >= Minlength and cadena.length <= Maxlength then
			return true
		else
			return false
		end 
		
	end 

	def self.isAlphanumericformat (cadena)
		
		patron_regex = /\W/ #patrón regex / inicio o fin de patron; \W carácter que no sea número ni letra

		if cadena.match(patron_regex) != nil then

			return false
		else
			return true
		end
		
	end

	def self.isValidmailformat (cadena)
		
		patron_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

		if cadena.match(patron_regex) != nil then
			return true
		else
			return false
		end
		
	end 

end 