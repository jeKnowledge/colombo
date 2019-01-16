class Admin::TermsController < ApplicationController
  before_action :admin_authenticated?
  before_action :set_term, except: [:index, :new, :create]

  layout 'admin'

  def index
    @terms = Term.order(active: :desc).order(:date)
  end

  def new
    @term = Term.new
  end

  def create
    @term = Term.new(term_params)

    if @term.save
      @term.select if Term.count == 1
      redirect_to admin_terms_path
    else
      render :new
    end
  end

  def update
    if @term.update_attributes(term_params)
      @term.set_date
      redirect_to admin_terms_path
    else
      render :edit
    end
  end

  def destroy
    @term.destroy
    Term.first.update_attribute(:active, true) if @term.active && Term.count >= 1
    redirect_to admin_terms_path
  end

  def select
    @term.select
    redirect_to admin_terms_path
  end

  private
    def set_term
      @term = Term.find(params[:id])
    end

    def term_params
      params.require(:term).permit(:body)
    end
end
