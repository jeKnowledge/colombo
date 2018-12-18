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
      redirect_to auditor_reports_path, notice: "Report sent successfully"
    else
      render :report
    end
  end

  def reports
    @reports = @auditor.reports.order(:date)
  end

  def show_report
    @report = Report.find(params[:id])
  end

  def plan
    @plan = Plan.new
  end

  def plan_send
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to auditor_plans_path, notice: "Plan sent successfully"
    else
      render :plan
    end
  end

  def plans
    @plans = @auditor.plans.order(:date)
  end

  def show_plan
    @plan = Plan.find(params[:id])
  end

  private
    def report_params
      params.require(:report)
        .permit(:products, :price, :summary, :report).merge(auditor_id: @auditor.id)
    end

    def plan_params
      params.require(:plan)
        .permit(:products, :price, :date, :summary, :fee).merge(auditor_id: @auditor.id)
    end
end
