class Client::AuditsController < ApplicationController
  def search
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

    @reports = reports.distinct.validated().paginate(params[:report_page], 5)
    @plans = plans.distinct.validated().not_expired().paginate(params[:report_page], 5)
  end

  def reserve
  end

  def buy
  end

=begin 
  def request
    @request = Request.new(request_params)

    if @request.save
      redirect_to dashboard_client_path
    else
      render :search
    end
  end

  private
    def request_params
      params.require(:request)
        .permit(:company, :address, :date, :products).merge(client_id: current_user.id)
    end
=end
end
