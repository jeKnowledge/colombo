class Auditor::AuditsController < ApplicationController
  def report
  end

  def report_send
    @report = Report.new(report_params)

    if @report.save
      redirect_to dashboard_path(current_user)
    else
      ap @report.errors.full_messages
      render :report
    end
  end

  def plan
  end

  def plan_send
  end

  private

    def report_params
      params.require(:report).permit(:site, :address, :date, :products).merge(auditor_id: current_user.id)
    end
end
