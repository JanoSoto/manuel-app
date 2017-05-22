class Client < ActiveRecord::Base
	validates_uniqueness_of :clientEmail, :clientRut

	def full_name
    	full_name =  self.clientName.to_s + " " + self.clientLastName.to_s
    	return full_name
	end

	def display_client
		display_client = self.clientRut.to_s + " - " + self.full_name.to_s
		return display_client
	end
end
