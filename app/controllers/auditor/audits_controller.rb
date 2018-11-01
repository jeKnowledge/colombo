class Auditor::AuditsController < ApplicationController
  before_action :auditor_authenticated?
  before_action :auditor_validated?

  layout 'auditor'

  def report
    @report = Report.new
  end

  def report_send
    @report = Report.new(report_params)

    if @report.save
      redirect_to reports_auditor_audits_path
    else
      render :report
    end
  end

  def reports
    @reports = current_user.reports.order(:date)
  end

  def plan
    @plan = Plan.new
  end

  def plan_send
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to plans_auditor_audits_path
    else
      render :plan
    end
  end

  def plans
    @plans = current_user.plans.order(:date)
  end

  private

  def report_params
    params.require(:report)
      .permit(:products, :price, :summary, :report).merge(auditor_id: current_user.id)
  end

  def plan_params
    params.require(:plan)
      .permit(:products, :price, :date, :summary).merge(auditor_id: current_user.id)
  end
end
