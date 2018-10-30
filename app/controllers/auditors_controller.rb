class AuditorsController < ApplicationController
  before_action :auditor_authenticated?, only: [:index, :edit, :update, :show, :destory]
  before_action :auditor_validated?, only: [:index, :edit, :update, :show, :destory]

  def index
  end

  def new
    @auditor = Auditor.new
  end

  def create
    @auditor = Auditor.new(auditor_params)

    if @auditor.terms == "0"
      @auditor.errors.add(:terms, :blank, message: "must be accepted")
      render :new
    elsif @auditor.save
      session[:user_id] = @auditor.id
      redirect_to dashboard_auditor_path
    else
      render :new
    end
  end

  private
    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications, :cv, :password, :password_confirmation, :terms)
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
end
