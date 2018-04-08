class NotificationMailer < ApplicationMailer

  def notify_survey(user, survey)
    @user = user
    @survey = survey
    mail(to: @user.email, subject: 'Tienes una encuesta pendiente')
  end

end
