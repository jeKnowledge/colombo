class ClientsController < ApplicationController
  before_action :client_authenticated?, only: [:index, :edit, :update, :show, :destory]
  before_action :client_validated?, only: [:index, :edit, :update, :show, :destory]

  def index
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

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

  private
    def client_params
      params.require(:client).permit(:password, :password_confirmation, :first_name, :last_name, :email, :address, :company, :terms)
    end

    def client_authenticated?
      unless session[:user_id] && Client.exists?(session[:user_id])
        redirect_to sign_in_path
      end
    end

    def client_validated?
      unless current_user.validated
        render '/shared/not_validated'
      end
    end
end
