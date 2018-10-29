class AuditorController < ApplicationController
  def index
  end

  def new
    @auditor = Auditor.new
  end

  def create
    user = User.new(auditor_params)
    @auditor = Auditor.new(auditor_params)
    
    unless user.valid? && @auditor.valid?
      @auditor.errors.push(user.errors)
      render :new
    end

    user.save
    @auditor.user = user
    @auditor.save
    user.update_attribute(:username , "a_#{user.first_name[0..2]}#{user.last_name[0..2]}#{user.id}")

    redirect_to auditor_path
  end

  private
    def auditor_params
      params.require(:auditor).permit(:first_name, :last_name, :email, :qualification, :cv, :password, :password_confirmation)
    end
end
