class QueriesController < ApplicationController
  def index
    @queries = Query.all
    @query = Query.new
  end

  def create
    @query = Query.new(query_params)
    QueryCalculator.calculate(@query)
    if @query.save
      redirect_to root_path
    else
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
