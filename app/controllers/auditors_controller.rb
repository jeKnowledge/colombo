class AuditorsController < ApplicationController
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
      @auditor.update_attribute(:username , "a_#{@auditor.first_name[0..2]}#{@auditor.last_name[0..2]}#{@auditor.id}")
      redirect_to dashboard_auditor_path
    else
      render :new
    end
  end

  private
    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualifications, :cv, :password, :password_confirmation, :terms)
    end
end
