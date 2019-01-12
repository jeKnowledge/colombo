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

  def new_forgot_password
  end

  def create_forgot_password
    user = User.find_by(email: forgot_password_params[:email])

    if user
      forgot_password = ForgotPassword.create(user: user)
      UserMailer.password_recovery(user, forgot_password.token).deliver
      redirect_to sign_in_path
    else
      flash.now[:notice] = "Invalid email"
      render :new_forgot_password
    end
  end

  def new_change_password
    forgot_password = ForgotPassword.find_by(token: params[:token])

    if forgot_password
      @user = forgot_password.user
      forgot_password.destroy
    else
      render file: "#{Rails.root}/public/Colombo/Colombo/html/404.html", layout: false, status: 404
    end
  end

  def create_change_password
    @user = User.find(params[:user_id])

    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      redirect_to sign_in_path
    else
      render :new_change_password
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

    def forgot_password_params
      params.permit(:email)
    end
end
