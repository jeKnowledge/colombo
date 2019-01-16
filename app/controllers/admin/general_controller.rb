class Admin::GeneralController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_user, only: [:show_user, :validate_user, :invalidate_user, :delete_user]
  before_action :set_audit, only: [:show_audit, :validate_audit]

  include ConversationHandler

  layout 'admin'

  def index(admin=Admin.new)
    @admin = admin
    @auditors = Auditor.order(:validated).page(params[:auditor_page]).per(5)
    @clients = Client.order(:validated).page(params[:client_page]).per(5)
    @reports = Report.order(:validated).page(params[:report_page]).per(5)
    @plans = Plan.order(:validated).page(params[:plan_page]).per(5)
    @requests = Request.order(:created_at).page(params[:request_page]).per(5)
    @messages = Message.order(:created_at).page(params[:message_page]).per(5)
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_dashboard_path
    else
      index(@admin)
      render :index
    end
  end

  def show_user
  end

  def show_audit
  end

  def show_request
    @request = Request.find(params[:id])
  end

  def show_message
    @message = Message.find(params[:id])
  end

  def validate_user
    @user.update_column(:validated, true)
    redirect_to admin_dashboard_path
  end

  def invalidate_user
    @user.update_column(:validated, false)
    redirect_to admin_dashboard_path
  end

  def delete_user
    @user.destroy
    redirect_to admin_dashboard_path
  end

  def validate_audit
    @audit.update_column(:validated, true)
    redirect_to admin_dashboard_path
  end

  def set_default_report_rating
    Report::set_default_rating(params[:rating])
    redirect_to admin_dashboard_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_audit
      @audit = Audit.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:email)
    end
end