class SupportersController < ApplicationController
  before_filter :set_form_timestamp, only: :new

  def new
    @supporter = Supporter.new
  end

  def create
    @supporter = Supporter.new supporter_form_params
    if !input_to_fast? && @supporter.save
      redirect_to thanks_path
    else
      flash.now[:danger] = t '.timeout' if input_to_fast?
      render :new
    end
  end

  private

  def supporter_form_params
    params.require(:supporter).permit(:first_name, :last_name, :street, :zip, :email, :support, :age_category, :city, :comments)
  end
end
