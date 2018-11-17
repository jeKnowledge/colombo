class AuditorsController < ApplicationController
  before_action :auditor_authenticated?, except: [:create, :new]
  before_action :auditor_validated?, except: [:create, :new]
  before_action :set_auditor, except: [:create, :new]

  layout 'auditor', except: [:new, :create]

  def index
  end

  def new
    @auditor = Auditor.new
  end

  def create
    @auditor = Auditor.new(auditor_signup_params)

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

  def show
  end

  def edit
  end

  def update
    if @auditor.update_attributes(auditor_params)
      redirect_to profile_auditor_path
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to sign_out_path
  end

  def purchases
    @purchases = Purchase.where(auditor_id: current_user.id)
  end

  def reservations
    @reservations = Reservation.where(auditor_id: current_user.id)
  end

  private
    def auditor_signup_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications, :cv, :password, :password_confirmation, :terms)
    end

    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications)
    end

    def set_auditor
      @auditor = current_user
    end
end
