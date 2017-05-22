class Client < ActiveRecord::Base
	has_many :pets
	has_many :payments
	validates_uniqueness_of :clientEmail, :clientRut
	def payments_total
		total=0
		self.payments.each do |pay|
			if pay.verified
				total = total + pay.amount
			end
		end
		total
	end

	def full_name
    	full_name =  self.clientName.to_s + " " + self.clientLastName.to_s
    	return full_name
	end

	def display_client
		display_client = self.clientRut.to_s + " - " + self.full_name.to_s
		return display_client
	end
end
