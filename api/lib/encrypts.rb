class Encrypts
	#Esta librería contiene los métodos de encriptado de cadena
	require "digest"

	attr_accessor :str, :seek

	def initialize(cadena, salt)
		@str = cadena
		@seek = salt
	end


	def self.encrypt(cadena, salt)
		return secure_hash ("#{salt}--#{cadena}")
	end

	private

		def self.secure_hash(cadena)
			Digest::SHA2.hexdigest(cadena)
		end 

end