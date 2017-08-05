class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:not_found, 
                                              :internal_server_error]


  private

    def render_404
      respond_to do |format|
        format.html { redirect_to '404', status: 404, turbolinks: false }
        format.json { render json: { status: 404, message: 'Page Not Found' } }
      end
    end
    def render_500
      respond_to do |format|
        format.html { redirect_to '500', status: 500 , turbolinks: false }
        format.json { render json: { status: 500, message: 'Internal server error' } }
      end 
    end 
end
