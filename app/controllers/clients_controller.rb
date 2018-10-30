class ClientsController < ApplicationController
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
      redirect_to dashboard_client_path
    else
      render :new
    end
  end

  private
    def client_params
      params.require(:client).permit(:password, :password_confirmation, :first_name, :last_name, :email, :address, :company, :terms)
    end
end
