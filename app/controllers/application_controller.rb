class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  # Override Devise default redirect path for sign in
  def after_sign_in_path_for(resouce)
    searches_path
  end
end
