class Admin::ContractsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_contract, except: [:index, :new, :create]

  layout 'admin'

  def index
    @contracts = Contract.order(active: :desc).order(:date)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      @contract.select if Contract.count == 1
      redirect_to admin_contracts_path
    else
      render :new
    end
  end

  def update
    if @contract.update_attributes(contract_params)
      @contract.set_date
      redirect_to admin_contracts_path
    else
      render :edit
    end
  end

  def destroy
    @contract.destroy
    Contract.first.update_attribute(:active, true) if @contract.active && Contract.count >= 1
    redirect_to admin_contracts_path
  end

  def select
    @contract.select
    redirect_to admin_contracts_path
  end

  def download
    pdf_format = WickedPdf.new.pdf_from_string(Markdown.new(@contract.body).to_html)

    save_path = Rails.root.join('storage','contract.pdf')
    File.open(save_path, 'wb') { |file| file << pdf_format }

    send_file "storage/contract.pdf", type: 'application/pdf'
  end

  private
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:body)
    end
end
