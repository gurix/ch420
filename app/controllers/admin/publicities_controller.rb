module Admin
  class PublicitiesController < Admin::ApplicationController
    def index
      @pending = Supporter.where('publicity.state' => :pending).asc(:created_at)
      @active = Supporter.where('publicity.state' => :approved).asc(:created_at)
    end

    def edit
      @publicity = Supporter.find(params[:id]).publicity
    end

    def update
      @publicity = Supporter.find(params[:id]).publicity
      return redirect_to(admin_publicities_path) if @publicity.update_attributes(publicity_params)
      render :edit
    end

    def destroy
      current_supporter.publicity&.destroy
      redirect_to(admin_publicities_path)
    end

    private

    def publicity_params
      params.require(:publicity).permit(:organisation, :statement, :avatar, :state)
    end
  end
end
