class Client::AuditsController < ApplicationController
  def search
  end

  def reserve
  end

  def buy
  end

  def new_request
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
      params.require(:request).permit(:site, :address, :date, :products).merge(client_id: current_user.id)
    end
end
