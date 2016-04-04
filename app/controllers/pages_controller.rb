class PagesController < ApplicationController
  def thanks
  end

  def map
    @supporters = Supporter.where(:coordinates.ne => nil).only(:coordinates, :support)
  end
end
