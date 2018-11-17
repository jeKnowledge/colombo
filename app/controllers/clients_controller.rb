class ClientsController < ApplicationController
  before_action :client_authenticated?, except: [:create, :new]
  before_action :client_validated?, except: [:create, :new]
  before_action :set_client, except: [:new, :create]

  layout 'client', except: [:new, :create]

  def index
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_signup_params)

    unless @client.terms_accepted
      @client.errors.add(:terms, :blank, message: "must be accepted")
      render :new
    else
      if @client.save
        session[:user_id] = @client.id
        redirect_to dashboard_client_path
      else
        render :new
      end
    end
  end

  def show
  end

  def profile
    @client = Client.find(params[:id])
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
    @reservations = current_user.reservations
  end

  def purchases
    @purchases = current_user.purchases
  end

  private
    def client_signup_params
      params.require(:client).permit(
        :password, :password_confirmation, :first_name, :last_name,
        :email, :address,:company, :terms_accepted
      )
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :email, :address, :company)
    end

    def set_client
      @client = current_user
    end
end
