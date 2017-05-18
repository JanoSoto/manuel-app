class UserMailer < ApplicationMailer
	def welcome_new_user(user)
		@user = user
	end
end
