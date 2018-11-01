class Client::AuditsController < ApplicationController
  def search
    if params[:query] && params[:query].present?
      @reports = Report.where(validated: true).where("products LIKE ?", params[:query])
      @plans = Plan.where(validated: true).where("products LIKE ?", params[:query]).where("date > ?", Time.now)
    else
      @reports = Report.all
      @plans = Plan.all
    end

    @reports = @reports.page(params[:report_page]).per(5)
    @plans = @plans.page(params[:report_page]).per(5)
  end

  def reserve
  end

  def buy
  end

  def new_request
    @request = Request.new
  end

  def request_send
    @request = Request.new(request_params)

    if @request.save
      redirect_to dashboard_path(current_user)
    else
      render :new_request
    end
  end

  private
    def request_params
      params.require(:request)
        .permit(:site, :address, :date, :products).merge(client_id: current_user.id)
    end
end
