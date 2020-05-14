class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Assigns currently logged in user to 'current_user'
  def current_user
    @user ||= User.where("id=?", session[:user_id]).first
  end
  helper_method :current_user

  # Redirects the user to the login page if the current_user is nil
  def require_login
    if !logged_in?
      redirect_to login_path
    end
  end

  # Checks if a user is logged in or not
  def logged_in?
    !current_user.nil? && !current_user.id.nil?
  end
  helper_method :logged_in?

end
