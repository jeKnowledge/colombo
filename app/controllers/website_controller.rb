class WebsiteController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.where('username = ? OR email = ?', params[:username], params[:username]).first

    if user.nil?
      flash[:notice] = "Invalid credentials"
      render :new
    else
      if params[:password] == user.password
        session[:user] = user

        case user.type_id
        when User.ADMIN
          redirect '/admin'
        when User.AUDITOR
          redirect '/auditor'
        when User.CLIENT
          redirect '/client'
        end
      else
        flash[:notice] = "Invalid credentials"
        render :new
      end
    end
  end
end
