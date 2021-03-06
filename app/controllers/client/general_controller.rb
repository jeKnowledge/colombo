class Client::GeneralController < ApplicationController
  before_action :client_authenticated?, except: [:create, :new]
  before_action :user_validated?, except: [:create, :new]
  before_action :set_client, except: [:new, :create]

  layout 'client', except: [:new, :create]

  def index
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      session[:user_id] = @client.id
      redirect_to client_dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def profile
  end

  def edit
  end

  def update
    if @client.update_attributes(client_params)
      redirect_to client_profile_path
    else
      render :edit
    end
  end

  def delete
    @client.destroy
    redirect_to sign_out_path
  end

  def requests
    @requests = @client.requests
  end

  def reservations
    @reservations = @client.reservations
  end

  def purchases
    @purchases = @client.purchases
  end

  def rate_purchase
    purchase = Purchase.find(params[:id])

    if @client.purchases.include?(purchase)
      purchase.rate(params[:rating].to_i.clamp(0, 5))
    end

    redirect_to client_purchases_path, note: "Thanks for the rating"
  end

  def download_audit
    purchase = Purchase.find(params[:id])
    audit = purchase.report
    send_file File.open(File.join(Rails.root, audit.report.url)) if purchase.client_id = session[:user_id]
  end

  def accept_terms
    @client.update_attribute(:terms_of_service, true)
    redirect_to client_dashboard_path
  end

  def show_auditor
    @auditor = Auditor.find(params[:id])
  end

  private
    def client_params
      params.require(:client).permit(
        :name, :email, :address, :country, :company
      )
    end

    def set_client
      @client = Client.find(session[:user_id])
    end
end
