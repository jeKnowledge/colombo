class ValidationsController < ApplicationController
  def index
    @unvalidated_auditors = Auditor.where(validated: false)
  end

  def validate
    user = User.find(params[:user_id])
    if is_admin?
      user.update_attribute(:validated, true)
      redirect_to admin_validations_path
    else
      reditect_to root_path
    end
  end

  private
  def is_admin?
    Admin.exists?(current_user.id)
  end
end
