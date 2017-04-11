class PagesController < ApplicationController
  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render plain: t('.not_found'), status: :not_found
    end
  end

  private

  def valid_page?
    return true if File.exist?("#{Rails.root}/app/views/pages/#{params[:page]}.#{I18n.locale}.slim")
    return true if File.exist?("#{Rails.root}/app/views/pages/#{params[:page]}.#{I18n.default_locale}.slim")
  end
end
