class WebsiteController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = Client.find_by_username(params[:username])
    user = Auditor.find_by_username(params[:username]) if user.nil?
    user = Admin.find_by_username(params[:username]) if user.nil?

    if user.nil?
      flash[:notice] = "Invalid credentials"
      render :new
    else
      if params[:password] == user.password
        session[:user] = user

        if user.is_a? User
          redirect_to users_path
        elsif user.is_a? Auditor
          redirect_to auditors_path
        elsif user.is_a? Admin
          redirect_to admin_path
        end
      else
        flash[:notice] = "Invalid credentials"
        render :new
      end
    end
  end
end
