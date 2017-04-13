class PublicitiesController < ApplicationController
  before_action :authenticate_supporter!

  def new
    @publicity = current_supporter.publicity || Publicity.new
  end

  def create
    @publicity = Publicity.new(publicity_params.merge(supporter: current_supporter, state: :pending))
    flash['success'] = t('.success') if @publicity.valid?
    return redirect_to(root_path) if @publicity.save
    render :new
  end

  def update
    create
  end

  def destroy
    current_supporter.publicity&.destroy
    redirect_to(root_path)
  end

  private

  def publicity_params
    params.require(:publicity).permit(:organisation, :statement, :avatar)
  end
end
