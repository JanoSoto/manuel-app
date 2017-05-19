class Client < ActiveRecord::Base
	has_many :pets
	has_many :payments
	validates_uniqueness_of :clientEmail, :clientRut
	def payments_total
		total=0
		self.payments.each do |pay|
			total = total + pay.amount
		end
		total
	end
end
