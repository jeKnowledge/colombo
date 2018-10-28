class AuditorController < ApplicationController
  def index
  end

  def new
    @auditor = Auditor.new
  end

  def create
    @auditor = Auditor.new(auditor_params)

    if @auditor.save
      render :new
    else
      redirect_to auditor_path
    end
  end

  private
    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualification, :cv, :password, :password_confirmation)
    end
end
