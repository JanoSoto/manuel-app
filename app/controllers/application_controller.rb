class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
      # Función que notifica, mediante correo, a un usuario de la aplicación un mensaje.
    # * *Args*    :
    #   - +message+ -> Es el mensaje que se desea que reciban los administradores
    def notify_user(user,message)
        NotificationMailer.notification_email(user, current_user,message).deliver
    end 
end
