module Admin
  class SupportersController < Admin::ApplicationController
    def index
      @supporters = Supporter.desc(:created_at)
    end
  end
end
