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
end
