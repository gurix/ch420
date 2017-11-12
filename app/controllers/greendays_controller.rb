class GreendaysController < ApplicationController
  before_action :only_admin, except: [:index, :show]
  before_action :set_greenday, only: [:show, :edit, :update, :destroy]

  def index
    @greendays = Greenday.all.sort(title: 1)
  end

  def new
    @greenday = Greenday.new
  end

  def edit; end

  def create
    @greenday = Greenday.new(greenday_params)

    respond_to do |format|
      if @greenday.save
        format.html { redirect_to greendays_path, success: 'Greenday was successfully created.' }
        format.json { render :show, status: :created, location: @greenday }
      else
        format.html { render :new }
        format.json { render json: @greenday.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @greenday.update(greenday_params)
        format.html { redirect_to greendays_path, notice: 'Greenday was successfully updated.' }
        format.json { render :show, status: :ok, location: @greenday }
      else
        format.html { render :edit }
        format.json { render json: @greenday.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @greenday.destroy
    respond_to do |format|
      format.html { redirect_to greendays_path, notice: 'Greenday was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_greenday
    @greenday = Greenday.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def greenday_params
    params.require(:greenday).permit(:title, :address, :homepage, :description, :logo, :delete_logo)
  end

  def only_admin
    return true if current_supporter && current_supporter.admin?
    raise ActionController::RoutingError, 'Not Found'
  end
end
