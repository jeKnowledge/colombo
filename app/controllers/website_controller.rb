class WebsiteController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.find_by_username(sign_in_params)

    if user.nil?
      flash[:notice] = "Invalid credentials"
      render :new
    else
      if params[:password] == user.password
        session[:user] = user

        if user.client_id.present?
          redirect_to users_path
        elsif user.auditor_id.present?
          redirect_to auditors_path
        elsif user.admin_id.present?
          redirect_to admin_path
        end
      else
        flash[:notice] = "Invalid credentials"
        render :new
      end
    end
  end

  private
    def sign_in_params
      params.require(:username, :password)
    end
end
