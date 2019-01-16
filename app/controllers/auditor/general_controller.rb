class Auditor::GeneralController < ApplicationController
  before_action :auditor_authenticated?, except: [:create, :new]
  before_action :user_validated?, except: [:create, :new]

  include ConversationHandler

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
      @auditor.notify_cv_update if auditor_params[:cv].present?

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

    Request.all.each do |request|
      like_address = !(@auditor.address =~ /.*#{request.address}.*/).nil?
      like_company = !(@auditor.company =~ /.*#{request.company}.*/).nil?

      if like_address && like_company
        @requests << request
      end
    end
  end

  def show_client
    @client = Client.find(params[:id])
  end

  private
    def auditor_signup_params
      params.require(:auditor).permit(
        :name, :email, :qualifications, :cv, :address, :company, :country, :cv_cache
      )
    end

    def auditor_params
      params.require(:auditor).permit(
        :name, :email, :qualifications, :password, :password_confirmation,
        :address, :company, :country, :cv, :cv_cache
      )
    end
end
