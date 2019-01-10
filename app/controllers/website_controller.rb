class WebsiteController < ApplicationController
  def index
  end

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    puts "P #{user.password}"

    if user && BCrypt::Password.new(user.password) == sign_in_params[:password]
      session[:user_id] = user.id
      redirect_to dashboard_path(user)
    else
      flash[:notice] = "Invalid credentials"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def terms
    @terms = Consent.terms.active
  end

  def accept_terms
    unless User.exists?(session[:user_id])
      redirect_to sign_in_path
    else
      current_user = User.find(session[:user_id])
      current_user.update_attribute(:terms_of_service, true)
      redirect_to dashboard_path(current_user)
    end
  end

  private
    def sign_in_params
      params.permit(:username, :password, :remember_me)
    end
end
