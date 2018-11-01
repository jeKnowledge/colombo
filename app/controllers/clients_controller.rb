class ClientsController < ApplicationController
  before_action :client_authenticated?, only: [:index, :edit, :update, :show, :destory]
  before_action :client_validated?, only: [:index, :edit, :update, :show, :destory]

  layout 'client', except: [:new, :create]

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

  def show
  end

  def mail
  end

  def requests
  end

  def reservations
  end

  def purchases
  end

  private
    def client_params
      params.require(:client).permit(:password, :password_confirmation, :first_name, :last_name, :email, :address, :company, :terms)
    end
end
