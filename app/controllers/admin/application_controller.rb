module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_supporter!
    before_action :authenticate_admin!

    def authenticate_admin!
      return true if current_supporter.admin?
      head(:forbidden)
    end

    def admin_area
      true
    end
  end
end
