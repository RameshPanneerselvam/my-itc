class Usermailer1Mailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.usermailer1_mailer.mail1.subject
  #
  def mail1(user)

    @user = "user.email"

    mail to: user.contact[0].email
  end
end
