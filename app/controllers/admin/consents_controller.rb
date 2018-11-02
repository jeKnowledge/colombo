class Admin::ConsentsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_consent, only: [:toggle, :show, :destroy]

  layout 'admin'

  def index
    @consents = Consent.all
  end

  def show
  end

  def destroy
    @consent.destroy
    redirect_to admin_consents_path
  end

  def update
  end

  def toggle
    @consent.update_column(:active, !@consent.active)
    redirect_to admin_consents_path
  end

  private

    def set_consent
      @consent = Consent.find(params[:id])
    end
end
