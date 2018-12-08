module WebsiteHelper
  include ActionView::Helpers::UrlHelper

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

  def client_authenticated?
    unless session[:user_id] && Client.exists?(session[:user_id])
      redirect_to sign_in_path
    else
      @client = Client.find(session[:user_id])
    end
  end

  def client_validated?
    unless @client.validated
      @client.errors.add(:your_account, "hasn't been validated yet, please wait until our administrators have done so.")
    end

    unless @client.terms_of_service
      @client.errors.add(:new_terms, "have been set. To continue using the platform you must accept them. Accept #{link_to 'terms', terms_path}. #{link_to 'Accept', accept_terms_client_path, method: :post}")
    end

    unless @client.errors.count == 0
      render 'shared/not_allowed' unless profile_client_path == request.path
    end
  end

  def auditor_authenticated?
    unless session[:user_id] && Auditor.exists?(session[:user_id])
      redirect_to sign_in_path
    else
      @auditor = Auditor.find(session[:user_id])
    end
  end

  def auditor_validated?
    unless @auditor.validated
      @auditor.errors.add(:your_account, "hasn't been validated yet, please wait until our administrators have done so.")
    end

    unless @auditor.terms_of_service
      @auditor.errors.add(:new_terms, "have been set. To continue using the platform you must accept them. Accept #{link_to 'terms', terms_path}. #{link_to 'Accept', accept_terms_auditor_path, method: :post}")
    end

    unless @auditor.errors.count == 0
      render 'shared/not_allowed' unless profile_auditor_path == request.path
    end
  end

  def admin_authenticated?
    unless session[:user_id] && Admin.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end
end
