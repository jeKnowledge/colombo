class Client::AuditsController < ApplicationController
  before_action :client_authenticated?
  before_action :client_validated?

  layout 'client'

  def search
    @search_query = params[:query]

    if params[:query] && !params[:query].empty?
      reports = Report.products_like(params[:query])
      plans = Plan.products_like(params[:query])

      Auditor.company_address_like(params[:query]).each do |auditor|
        reports = reports.or(auditor.reports)
        plans = plans.or(auditor.plans)
      end
    else
      reports = Report.all
      plans = Plan.all
    end

    @reports = reports.validated().paginate(params[:report_page], 5)
    @plans = plans.validated().not_expired().paginate(params[:report_page], 5)
  end

  def advanced_search
    @search_company = params[:company]
    @search_address = params[:address]
    @search_products = params[:products]

    reports = Report.validated()
    plans = Plan.validated().not_expired()

    unless params[:products].empty?
      reports = reports.products_like(params[:products])
      plans = plans.products_like(params[:products])
    end

    unless params[:company].empty?
      report_collection = nil
      plan_collection = nil

      Auditor.company_like(params[:company]).each do |auditor|
        report_collection = (report_collection.nil?) ? auditor.reports : report_collection.or(auditor.reports)
        plan_collection = (plan_collection.nil?) ? auditor.plans : plan_collection.or(auditor.plans)
      end

      reports = reports.merge(report_collection) unless report_collection.nil?
      plans = plans.merge(plan_collection) unless plan_collection.nil?
    end

    unless params[:address].empty?
      report_collection = nil
      plan_collection = nil

      Auditor.address_like(params[:company]).each do |auditor|
        report_collection = (report_collection.nil?) ? auditor.reports : report_collection.or(auditor.reports)
        plan_collection = (plan_collection.nil?) ? auditor.plans : plan_collection.or(auditor.plans)
      end

      reports = reports.merge(report_collection) unless report_collection.nil?
      plans = plans.merge(plan_collection) unless plan_collection.nil?
    end

    @reports = reports.paginate(params[:report_page], 5)
    @plans = plans.paginate(params[:report_page], 5)

    render :search
  end

  def reserve_preview
    @plan = Plan.find(params[:id])
  end

  def reserve
    plan = Plan.find(params[:id])
    Reservation.create(price: plan.price, plan_id: plan.id, client_id: @client.id, auditor_id: plan.auditor.id)
    redirect_to search_client_audits_path, notice: "Reservation completed successfully"
  end

  def purchase_preview
    @report = Report.find(params[:id])
  end

  def purchase
    report = Report.find(params[:id])
    Purchase.create(price: report.price, report_id: report.id, client_id: @client.id, auditor_id: report.auditor.id)
    redirect_to search_client_audits_path, notice: "Purchase completed successfully"
  end

  def make_request
    @request = Request.new
    render :request
  end

  def request_send
    @request = Request.new(request_params)

    if @request.save
      redirect_to search_client_audits_path, notice: "Request sent successfully"
    else
      render :request
    end
  end

  private
    def request_params
      params.require(:request).permit(:company, :address, :date, :products).merge(client_id: @client.id)
    end
end
