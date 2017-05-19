class Payment < ActiveRecord::Base
	validates :amount, :numericality => { :greater_than_or_equal_to => 0 }
	belongs_to :client

	def pay_date
		if !attributes['pay_date'].nil?
    		attributes['pay_date'].strftime("%m/%d/%Y %H:%M:%S")
		end
 	end
end
