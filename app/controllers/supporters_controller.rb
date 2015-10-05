class SupportersController < ApplicationController
  def new
    @supporter = Supporter.new
  end

  def create
    @supporter = Supporter.new supporter_form_params
    if @supporter.save
      redirect_to thanks_path
    else
      flash.now[:danger] = t 'shared.actions.failed'
      render :new
    end
  end

  private

  def supporter_form_params
    params.require(:supporter).permit(:first_name, :last_name, :street, :zip, :email, :support, :age_category)
  end
end
