class Admin::ConsentsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_consent, only: [:toggle, :show, :destroy, :update, :edit]

  layout 'admin'

  def new
    @consent = Consent.new
  end

  def create
    @consent = Consent.new(consent_params)

    if @consent.save
      redirect_to admin_consents_path
    else
      render :new
    end
  end

  def index
    @consents = Consent.all.order(active: :desc)
  end

  def show
  end

  def destroy
    @consent.destroy

    User.update_all(terms_of_service: false)

    redirect_to admin_consents_path
  end

  def edit
  end

  def update
    if @consent.update_attributes(consent_params)
      User.update_all(terms_of_service: false)

      redirect_to admin_consents_path
    else
      render :edit
    end
  end

  def toggle
    @consent.update_attributes(active: !@consent.active)

    User.update_all(terms_of_service: false) if @consent.active

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
