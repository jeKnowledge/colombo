module WebsiteHelper
  def get_path(user)
    if user.client_id.present?
      redirect_to client_path
    elsif user.auditor_id.present?
      redirect_to auditor_path
    elsif user.admin_id.present?
      redirect_to admin_path
    end
  end
end
