class SupporterMailer < ApplicationMailer
  include Roadie::Rails::Automatic

  def welcome_email(supporter)
    @supporter = supporter
    mail(to: @supporter.email, subject: I18n.t('welcome_email.subject'))
  end
end
