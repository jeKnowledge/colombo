class ClientsController < ApplicationController
  before_action :client_authenticated?, only: [:index, :edit, :update, :show, :destory]
  before_action :client_validated?, only: [:index, :edit, :update, :show, :destory]
  
  before_action :set_client, only: [:show, :edit, :update]

  layout 'client', except: [:new, :create]

  def index
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_signup_params)

    if @client.terms == "0"
      @client.errors.add(:terms, :blank, message: "must be accepted")
      render :new
    elsif @client.save
      session[:user_id] = @client.id
      redirect_to dashboard_client_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @client.update_attributes(client_params)
      redirect_to profile_auditor_path
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to sign_out_path
  end

  def mail
  end

  def requests
    @requests = current_user.requests
  end

  def reservations
  end

  def purchases
  end

  private
    def client_signup_params
      params.require(:client).permit(:password, :password_confirmation, :first_name, :last_name, :email, :address, :company, :terms)
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :email, :address, :company)
    end

    def set_client
      @client = current_user
    end
end
