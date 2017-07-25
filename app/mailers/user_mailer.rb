class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail(:to => user.email, :subject => "Recuperacion de contraseña")
  end
  def envio_de_password(user, password)
    @user = user.email
    @password = password
    mail(:to => user.email, :subject => "Detalles de su cuenta")
  end
end
