class AdminsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_user, only: [:show_user, :validate_user]
  before_action :set_audit, only: [:show_audit, :validate_audit]
  before_action :set_request, only: [:show_request, :validate_request]

  layout 'admin'

  def index
    @auditors = Auditor.order(:validated).page(params[:auditor_page]).per(5)
    @clients = Client.order(:validated).page(params[:client_page]).per(5)
    @reports = Report.order(:validated).page(params[:report_page]).per(5)
    @plans = Plan.order(:validated).page(params[:plan_page]).per(5)
    @requests = Request.order(:validated).page(params[:request_page]).per(5)
  end

  def show_user
  end

  def show_audit
  end

  def show_request
  end

  def validate_user
    @user.update_column(:validated, true)
    redirect_to dashboard_admin_path
  end

  def validate_audit
    @audit.update_column(:validated, true)
    redirect_to dashboard_admin_path
  end

  def validate_request
    @request.update_column(:validated, true)
    redirect_to dashboard_admin_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_audit
    @audit = Audit.find(params[:id])
  end

  def set_request
    @request = Request.find(params[:id])
  end
end
