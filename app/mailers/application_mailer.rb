class ApplicationMailer < ActionMailer::Base
  default from: "El Patio"
  layout 'mailer'

  def notification_email(user,current_user, message)
    @user = user
    @message = message
    @current_user=current_user
    mail(to: @user.email, subject: 'Notificaciones El Patio')
  end
  def client_notification_email(client, message)
    @client = client
    @message = message
    mail(to: @client.clientEmail, subject: 'Notificaciones El Patio')
  end
end
