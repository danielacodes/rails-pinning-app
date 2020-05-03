class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.where("id=?", session[:user_id]).first
  end
  helper_method :current_user

  # Redirects the user to the login page if the current_user is nil
  def require_login
    if current_user.nil?
      redirect_to login_path
    end
  end
end
