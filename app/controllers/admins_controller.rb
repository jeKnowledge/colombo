class AdminsController < ApplicationController
  before_action :admin_authenticates?

  def index
    @unvalidated_auditors = Auditor.where(validated: false)
  end

  def show_user
    @user = User.find(params[:id])
  end

  def validate_user
    user = User.find(params[:id])
    user.update_attribute(:validated, true)
    redirect_to dashboard_admin_path
  end

  private
    def admin_authenticates?
      unless session[:user_id].present? && Admin.exists?(session[:user_id])
        redirect_to sign_in_path
      end
    end
end
