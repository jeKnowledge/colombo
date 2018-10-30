class WebsiteController < ApplicationController
  def index
  end

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(sign_in_params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path(user)
    else
      flash[:notice] = "Invalid credentials"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
  end

  private
    def sign_in_params
      params.permit(:username, :password, :remember_me)
    end
end
