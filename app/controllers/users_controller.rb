class UsersController < ApplicationController
  before_action :authenticate_user!

  def new_user
  	@new_user = User.new
  end

  def create_user
  	user = User.new(user_params)
  	user.password = Devise.friendly_token.first(8)

  	respond_to do |format|
  		if user.save
  			user.send_reset_password_instructions
  			format.html {redirect_to root_path, notice: 'Nuevo usuario creado con éxito'}				
  		else
  			format.html {redirect_to new_user_path, alert: 'Ha ocurrido un error. Intente nuevamente'}
  		end
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :lastname, :phone)
    end
end
