module WebsiteHelper
  def dashboard_path(user)
    if user.is_a? Client
      return dashboard_client_path
    elsif user.is_a? Auditor
      return dashboard_auditor_path
    elsif user.is_a? Admin
      return dashboard_admin_path
    else
      return root_path
    end
  end

  def current_user
    User.find(session[:user_id])
  end
end
