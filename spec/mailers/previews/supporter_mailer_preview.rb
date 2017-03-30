# Preview all emails at http://localhost:3000/rails/mailers/supporter_mailer
class SupporterMailerPreview < ActionMailer::Preview
  def welcome
    I18n.locale = :de
    SupporterMailer.welcome_email(Supporter.first, SecureRandom.hex(5))
  end
end
