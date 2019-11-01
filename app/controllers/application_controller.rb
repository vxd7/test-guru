class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    unless current_user
      # Save original page user wanted to see
      # before forcing them to undergo login
      cookies[:before_login_page] = request.path
      redirect_to login_path, alert: 'Authentication failed! You are not '\
                                     'logged in or your session has expired'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
