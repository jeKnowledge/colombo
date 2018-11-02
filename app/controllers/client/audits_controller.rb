class Client::AuditsController < ApplicationController
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

    reports = Report.all.validated()
    plans = Plan.all.validated().not_expired()

    unless params[:products].empty?
      collection = Report.products_like(params[:query])
      reports = reports.merge(collection)
      collection = Plan.products_like(params[:query])
      plans = plans.merge(collection)
    end

    unless params[:company].empty?
      collection = nil
      Auditor.company_like(params[:company]).each do |auditor|
        if collection.nil?
          collection = auditor.reports
        else
          collection = collection.or(auditor.reports)
        end
      end

      reports = reports.merge(collection) unless collection.nil?
    end

    unless params[:address].empty?
      collection = nil
      Auditor.address_like(params[:address]).each do |auditor|
        if collection.nil?
          collection = auditor.reports
        else
          collection = collection.or(auditor.reports)
        end
      end

      reports = reports.merge(collection) unless collection.nil?
    end 
  
    @reports = reports.distinct.paginate(params[:report_page], 5)
    @plans = plans.distinct.paginate(params[:report_page], 5)

    render :search
  end

  def reserve
  end

  def purchase
  end

  def make_request
    @request = Request.new
    render :request
  end

  def request_send
    @request = Request.new(request_params)

    if @request.save
      redirect_to requests_client_path
    else
      render :request
    end
  end

  private
    def request_params
      params.require(:request).permit(:company, :address, :date, :products).merge(client_id: current_user.id)
    end
end
