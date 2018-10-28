class WebsiteController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(sign_in_params[:username])
      session[:user] = user
      #redirect_to get_path(user)
      redirect_to "/"
    else
      flash[:notice] = "Invalid credentials"
      redirect_to sign_in_url
    end
  end

  private
  def sign_in_params
    params.permit(:username, :password, :remember_me)
  end
end
