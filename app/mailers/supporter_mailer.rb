class SupporterMailer < ApplicationMailer
  include Roadie::Rails::Automatic

  def welcome_email(supporter, random_password)
    @supporter = supporter
    @password = random_password
    mail(to: @supporter.email, subject: I18n.t('welcome_email.subject'))
  end
end
