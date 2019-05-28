class SupportersController < ApplicationController
  before_filter :set_form_timestamp, only: :new

  def new
    @supporter = Supporter.new
  end

  def create
    @supporter = Supporter.new supporter_form_params.merge(language: I18n.locale)
    @supporter.password = random_password = SecureRandom.hex(5)
    if !input_to_fast? && @supporter.save
      # SupporterMailer.welcome_email(@supporter, random_password).deliver_now
      sendy_registraion
      redirect_to thanks_path
    else
      flash.now[:danger] = input_to_fast? ? t('.timeout') : t('input_error')
      render :new
    end
  end

  private

  def supporter_form_params
    params.require(:supporter).permit(:first_name, :last_name, :street, :zip, :email, :support, :li_membership, :age_category, :city, :comments, :tel)
  end

  # We use sendy for newsletters atm
  def sendy_registraion
    uri = URI('http://newsletter.cannabis-initiative.ch/subscribe')
    Net::HTTP.post_form(uri, list: ENV["SENDY_LIST_#{I18n.locale.upcase}"],
                             email: @supporter.email,
                             name: "#{@supporter.first_name} #{@supporter.last_name}")
  end
end
