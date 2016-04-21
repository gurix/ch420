# Preview all emails at http://localhost:3000/rails/mailers/supporter_mailer
class SupporterMailerPreview < ActionMailer::Preview
  def welcome
    I18n.locale = 'it'
    SupporterMailer.welcome_email(Supporter.first)
  end
end
