class SupportersController < ApplicationController
  def new
    @supporter = Supporter.new
  end
end
