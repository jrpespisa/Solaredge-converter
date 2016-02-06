class QueriesController < ApplicationController
  def index
    @queries = Query.all
    @query = Query.new
  end

  def create
    @queries = Query.all
    @query = Query.new(query_params)
    if @query.valid?
      QueryCalculator.calculate(@query)
      @query.save
      redirect_to root_path
    else
      flash[:notice] = "Please enter valid information."
      render :index
    end
  end

  private

  def query_params
    params.require(:query).permit(
    :kwh_rate,
    :kwh_credit,
    :kwh_generated,
    :sent_to_grid,
    :distribution_charge
    )
  end
end
