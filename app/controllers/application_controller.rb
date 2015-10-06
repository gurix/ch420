class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  INPUT_TIMEOUT = 2.seconds # We estimate that a user needs more then x seconds to enter some informations

  # calculate how long a user needed for a form input, ussually we just
  def input_to_fast?
    fail 'session[:form_timestamp] not set' unless session[:form_timestamp]
    duration = Time.now - session[:form_timestamp].to_time
    duration < INPUT_TIMEOUT
  end

  # Set the current timestamp that marks entering a form
  def set_form_timestamp
    session[:form_timestamp] = Time.now
  end
end
