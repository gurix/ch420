class SupportersController < ApplicationController
  before_filter :set_form_timestamp, only: :new

  def new
    @supporter = Supporter.new
  end

  def create
    @supporter = Supporter.new supporter_form_params.merge(language: I18n.locale)
    if !input_to_fast? && @supporter.save
      # SupporterMailer.welcome_email(@supporter).deliver_now
      mailchimp_registration
      redirect_to thanks_path
    else
      flash.now[:danger] = input_to_fast? ? t('.timeout') : t('input_error')
      render :new
    end
  end

  private

  def supporter_form_params
    params.require(:supporter).permit(:first_name, :last_name, :street, :zip, :email, :support, :li_membership, :age_category, :city, :comments)
  end

  def mailchimp_registration
    mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API'])
    mailchimp.lists.subscribe(ENV['CH420_LIST_ID'], { 'email' => @supporter.email }, merge_vars, 'html', false)
  end

  def merge_vars
    { 'EMAIL' => @supporter.email,
      'FNAME' => @supporter.first_name,
      'LNAME' => @supporter.last_name,
      'SUPPORT' => @supporter.support,
      'MEMBERSHIP' => @supporter.li_membership.to_s,
      'AGE' => @supporter.age_category,
      'LANG' => @supporter.language,
      'ZIP' => @supporter.zip }
  end
end
