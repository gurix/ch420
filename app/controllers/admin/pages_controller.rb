class PagesController < Admin::ApplicationController
  def map
    @supporters = Supporter.where(:coordinates.ne => nil).only(:coordinates, :support)
  end
end
