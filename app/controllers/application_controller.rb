class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :detect_ssl
  include SessionsHelper
  require 'app'
  include App
  require 'app_logging'
  include AppLogging

  def authenticate_admin_user!
    redirect_to root_path unless admin_signed_in?
  end

  def detect_ssl
    @ssl = request.ssl?
  end
end
