class AdminsController < ApplicationController
  before_action :admin_authenticates?
  before_action :set_user, only: [:show_user, :validate_user]
  before_action :set_audit, only: [:show_audit, :validate_audit]

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

  def validate_user
    @user.update_column(:validated, true)
    redirect_to dashboard_admin_path
  end

  def validate_audit
    @audit.update_column(:validated, true)
    redirect_to dashboard_admin_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_audit
    @audit = Audit.find(params[:id])
  end

  def admin_authenticates?
    unless session[:user_id] && Admin.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end
end
