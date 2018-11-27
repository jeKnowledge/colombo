class AuditorsController < ApplicationController
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

    if @auditor.terms_accepted
      @auditor.errors.add(:terms, :blank, message: "must be accepted")
      render :new
    elsif @auditor.save
      session[:user_id] = @auditor.id
      redirect_to dashboard_auditor_path
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
      redirect_to profile_auditor_path
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
    
    Request.validated.each do |request|
      like_address = !(@auditor.address =~ /.*#{request.address}.*/).nil?
      like_company = !(@auditor.company =~ /.*#{request.company}.*/).nil?

      if like_address && like_company
        @requests << request
      end
    end
  end

  def messages
    @messages_sent = @auditor.messages_sent.validated
    @messages_recieved = @auditor.messages_received.validated
  end

  def show_message
    @message = Message.find(params[:id])
  end

  def new_message
    @message = Message.new
    @clients_audits = @auditor.purchases.collect { |purchase| { client_id: purchase.client_id, products: purchase.report.products } }
    @clients_audits = @clients_audits + @auditor.reservations.collect { |reservation| { client_id: reservation.client_id, products: reservation.plan.products } }
  end

  def send_message
    audit = Audit.find(params[:message][:audit_id])
    message = Message.new(source: @auditor, destiny: audit.client, audit: audit, body: params[:message][:body])

    if message.save
      redirect_to messages_auditor_path, notice: "Message sent"
    else
      render :new_message
    end
  end

  def show_client
    @client = Client.find(params[:id])
  end

  def accept_terms
    @auditor.update_attribute(:terms_accepted, true)
    redirect_to dashboard_auditor_path
  end

  private
    def auditor_signup_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications, :cv, :password, :password_confirmation, :terms)
    end

    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications)
    end
end
