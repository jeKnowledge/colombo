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

  def client_authenticated?
    unless session[:user_id] && Client.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end

  def client_validated?
    unless current_user.validated
      render '/shared/not_validated'
    end
  end

  def auditor_authenticated?
    unless session[:user_id] && Auditor.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end

  def auditor_validated?
    unless current_user.validated
      render '/shared/not_validated'
    end
  end

  def admin_authenticated?
    unless session[:user_id] && Admin.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end
end
