class ClientController < ApplicationController
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
      @client.update_attribute(:username , "c_#{@client.first_name[0..2]}#{@client.last_name[0..2]}#{@client.id}")
      redirect_to client_path
    else
      render :new
    end
  end

  private
    def client_params
      params.require(:client).permit(:password, :password_confirmation, :first_name, :last_name, :email, :address, :company, :terms)
    end
end
