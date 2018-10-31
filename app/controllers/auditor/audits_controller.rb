class Auditor::AuditsController < ApplicationController
  def report
    @report = Report.new
  end

  def report_send
    @report = Report.new(report_params)

    if @report.save
      redirect_to dashboard_path(current_user)
    else
      render :report
    end
  end

  def reports
    @reports = Report.where(auditor_id: current_user.id)
  end

  def plan
    @plan = Plan.new
  end

  def plan_send
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to dashboard_path(current_user)
    else
      render :plan
    end
  end

  def plans
    @plans = Plan.where(auditor_id: current_user.id)
  end

  private

  def report_params
    params.require(:report)
      .permit(:site, :address, :date, :products).merge(auditor_id: current_user.id)
  end

  def plan_params
    params.require(:plan)
      .permit(:site, :address, :date, :products).merge(auditor_id: current_user.id)
  end
end
