class ClientController < ApplicationController
  def index
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(auditor_params)

    if @client.save
      render :new
    else
      redirect_to client_path
    end
  end

  private
    def client_params
      params.require(:client).permit(:first_name, :last_name, :email, :address, :company)
    end
end
