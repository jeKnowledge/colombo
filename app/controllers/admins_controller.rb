class AdminsController < ApplicationController
  before_action :admin_authenticates?
  before_action :set_user, only: [:show_user, :validate_user]

  def index
    @unvalidated_auditors = Auditor.order(:validated)
    @unvalidated_clients = Client.order(:validated)
  end

  def show_user
  end

  def validate_user
    @user.update_attribute(:validated, true)
    redirect_to dashboard_admin_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_authenticates?
    unless session[:user_id] && Admin.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end
end
