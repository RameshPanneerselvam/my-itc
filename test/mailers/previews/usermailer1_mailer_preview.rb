# Preview all emails at http://localhost:3000/rails/mailers/usermailer1_mailer
class Usermailer1MailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/usermailer1_mailer/mail1
  def mail1
    Usermailer1Mailer.mail1
  end

end
