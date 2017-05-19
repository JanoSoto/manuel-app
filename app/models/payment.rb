class Payment < ActiveRecord::Base
	validates :amount, :numericality => { :greater_than_or_equal_to => 0 }
	belongs_to :client

	def pay_date
    	attributes['pay_date'].strftime("%m/%d/%Y %H:%M:%S")
 	end
end
