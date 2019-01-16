module WebsiteHelper
  include ActionView::Helpers::UrlHelper

  def dashboard_path(user)
    return send(current_user.type.downcase + '_dashboard_path')
  end

  def conversation_path(type, id=1)
    case type
    when :index, :create
      send(current_user.type.downcase + '_conversations_path')
    when :show
      send(current_user.type.downcase + '_show_conversation_path', id)
    end
  end

  def message_path
    send(current_user.type.downcase + '_message_path')
  end

  def client_authenticated?
    unless session[:user_id] && Client.exists?(session[:user_id])
      redirect_to sign_in_path
    else
      @client = Client.find(session[:user_id])
    end
  end

  def auditor_authenticated?
    unless session[:user_id] && Auditor.exists?(session[:user_id])
      redirect_to sign_in_path
    else
      @auditor = Auditor.find(session[:user_id])
    end
  end

  def user_validated?
    @current_user = User.find(session[:user_id])

    unless @current_user.validated
      @current_user.errors.add(:your_account, "hasn't been validated yet, please wait until our administrators have done so.")
    end

    unless @current_user.terms_of_service
      @current_user.errors.add(:new_terms, "have been set. To continue using the platform you must accept them. Accept #{link_to 'terms', terms_path}. #{link_to 'Accept', accept_terms_path, method: :post}")
    end

    unless @current_user.errors.count == 0
      allowed = true

      if @current_user.is_a? Auditor
        allowed = auditor_profile_edit_path == request.path || auditor_profile_path == request.path
      else
        allowed = client_profile_edit_path == request.path || client_profile_path == request.path
      end

      render 'shared/not_allowed' unless allowed
    end
  end

  def admin_authenticated?
    unless session[:user_id] && Admin.exists?(session[:user_id])
      redirect_to sign_in_path
    end
  end

  def current_user
    user_id = session[:user_id]
    if user_id
      @current_user ||= User.find(user_id)
    end
  end
end
