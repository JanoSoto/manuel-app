class UsersController < ApplicationController
  

  def new_user
    if current_user.admin?
      @new_user = User.new
    else
      respond_to do |format|
        format.html {redirect_to root_path, alert: 'No tiene permisos para realizar esta operación'}
      end
    end
  end

  def create_user
    user = User.new(user_params)
  	user.password = Devise.friendly_token.first(8)
=begin
    if params[:admin]
      user.roles_id = 1
    else
      user.roles_id = 2
    end
=end
  	respond_to do |format|
  		if user.save
  			#user.send_reset_password_instructions
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
      params.require(:user).permit(:email, :name, :lastname, :roles_id)
    end
end
