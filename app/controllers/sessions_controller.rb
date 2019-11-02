class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # Redirect to the original page user wanted to see
      redirect_to user_redirect_path
      cookies[:before_login_page] = nil
    else
      flash.now[:alert] = 'Log in unsuccessfull. E-mail and/or password is incorrect!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def user_redirect_path
    cookies.fetch(:before_login_page, tests_path)
  end
end
