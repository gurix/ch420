class PagesController < ApplicationController
  def thanks
  end

  def map
    @supporters = Supporter.all.select(&:coordinates)
  end
end
