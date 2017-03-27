module Admin
  class ApplicationController < ApplicationController
    http_basic_authenticate_with name: 'admin', password: ENV['ADMIN_PASSWORD'] unless Rails.env.development?
  end
end
