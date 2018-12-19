class Auditor::GeneralController < ApplicationController
  before_action :auditor_authenticated?, except: [:create, :new]
  before_action :auditor_validated?, except: [:create, :new, :accept_terms]

  layout 'auditor', except: [:new, :create]

  def index
  end

  def new
    @auditor = Auditor.new
  end

  def create
    @auditor = Auditor.new(auditor_signup_params)

    if @auditor.save
      session[:user_id] = @auditor.id
      redirect_to auditor_dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @auditor.update_attributes(auditor_params)
      redirect_to auditor_profile_path
    else
      render :edit
    end
  end

  def destroy
    @auditor.destroy
    redirect_to sign_out_path
  end

  def purchases
    @purchases = @auditor.purchases
  end

  def reservations
    @reservations = @auditor.reservations
  end

  def requests
    @requests = []

    Request.each do |request|
      like_address = !(@auditor.address =~ /.*#{request.address}.*/).nil?
      like_company = !(@auditor.company =~ /.*#{request.company}.*/).nil?

      if like_address && like_company
        @requests << request
      end
    end
  end

  def messages
    @messages_sent = @auditor.messages_sent
    @messages_recieved = @auditor.messages_received
  end

  def show_message
    @message = Message.find(params[:id])
    @message.update_attribute(:read, true) if params[:read].present?
  end

  def new_message
    @message = Message.new
    @clients_audits = @auditor.purchases.collect { |purchase| [ "Products: #{purchase.report.products} Client: #{purchase.client.username}", "#{purchase.client_id}_#{purchase.report_id}" ] }
    @clients_audits = @clients_audits + @auditor.reservations.collect { |reservation| [ "Products: #{reservation.plan.products} Client: #{reservation.client.username}", "#{reservation.client_id}_#{reservation.plan_id}" ] }
  end

  def send_message
    client_audit_ids = params[:message][:client_audit_ids].split('_')
    client = Client.find(client_audit_ids[0].to_i)
    audit = Audit.find(client_audit_ids[1].to_i)

    message = Message.new(source: @auditor, destiny: client, audit: audit, body: params[:message][:body])

    if message.save
      redirect_to auditor_messages_path, notice: "Message sent"
    else
      @message = message
      @clients_audits = @auditor.purchases.collect { |purchase| [ purchase.report.products, purchase.client_id ] }
      @clients_audits = @clients_audits + @auditor.reservations.collect { |reservation| [ reservation.plan.products, reservation.client_id ] }
      render :new_message
    end
  end

  def show_client
    @client = Client.find(params[:id])
  end

  def accept_terms
    @auditor.update_attribute(:terms_of_service, true)
    redirect_to auditor_dashboard_path
  end

  private
    def auditor_signup_params
      params.require(:auditor).permit(
        :name, :email, :qualifications, :cv, :password,
        :password_confirmation, :terms_of_service,
        :address, :company, :country, :cv_cache
      )
    end

    def auditor_params
      params.require(:auditor).permit(
        :name, :email, :qualifications, :password, :password_confirmation,
        :address, :company, :country, :cv, :cv_cache
      )
    end
end
