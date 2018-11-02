class Admin::ConsentsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_consent, only: [:toggle, :show, :destroy, :update, :edit]

  layout 'admin'

  def new
    @consent = Consent.new
  end

  def create
    p = consent_params
    p[:type_id] = Consent.get_type_id(p[:type_id])
    @consent = Consent.new(p)

    if @consent.save
      redirect_to admin_consents_path
    else
      render :new
    end
  end

  def index
    @consents = Consent.all
  end

  def show
  end

  def destroy
    @consent.destroy
    redirect_to admin_consents_path
  end

  def edit
    @term_checked = false
    @contract_checked = false
    @cookies_checked = false
    case @consent.type_id
    when 0
      @term_checked = true
    when 1
      @contract_checked = true
    when 2
      @cookies_checked = true
    end
  end

  def update
    p = consent_params
    p[:type_id] = Consent.get_type_id(p[:type_id])
    if @consent.update_attributes(p)
      redirect_to admin_consents_path
    else
      render :edit
    end
  end

  def toggle
    @consent.update_column(:active, !@consent.active)
    redirect_to admin_consents_path
  end

  private

  def set_consent
    @consent = Consent.find(params[:id])
  end

  def consent_params
    params.require(:consent).permit(:type_id, :description)
  end
end
