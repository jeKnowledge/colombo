class Auditor::AuditsController < ApplicationController
  def report
  end

  def report_send
    @report = Report.new(report_params)

    if @report.save
      redirect_to dashboard_path(current_user)
    else
      render :report
    end
  end

  def plan
  end

  def plan_send
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to dashboard_path(current_user)
    else
      render :plan
    end
  end

  def audits
    @reports = Report.where(auditor_id: current_user.id)
    @plans = Plan.where(auditor_id: current_user.id)
  end

  private

  def report_params
    params.require(:report).permit(:site, :address, :date, :products).merge(auditor_id: current_user.id)
  end

  def plan_params
    params.require(:plan).permit(:site, :address, :date, :products).merge(auditor_id: current_user.id)
  end
end
