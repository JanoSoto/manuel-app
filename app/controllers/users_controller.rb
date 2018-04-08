class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update_user, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 15).order('created_at DESC')
  end

  def new_user
    if current_user.admin? or current_user.teacher?
      @new_user = User.new
    else
      respond_to do |format|
        format.html {redirect_to root_path, alert: 'No tiene permisos para realizar esta operación'}
      end
    end
  end

  def create_user
    user = User.new(user_params)
    user.password = 123456 #Devise.friendly_token.first(8)
    user.status = true
    respond_to do |format|
      if user.save
        # user.send_reset_password_instructions
        format.html {redirect_to users_url, notice: 'Nuevo usuario creado con éxito'}       
      else
        format.html {redirect_to new_user_path, alert: 'Ha ocurrido un error. Intente nuevamente'}
      end
    end
  end

  def show    
  end

  def edit_user
    @new_user = User.find(params[:id])
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Usuario editado satisfactoriamente' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, error: 'Ha ocurrido un error, intente nuevamente' }
      end
    end
  end

  def destroy
    @user.update(status: !@user.status)
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario '+(@user.status ? 'activado' : 'desactivado')+' satisfactoriamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :lastname, :roles_id, :status)
    end
end
