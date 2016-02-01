class QueriesController < ApplicationController
  def index
    @queries = Query.all
    @query = Query.new
  end

  def create
    @query = Query.new(query_params)
    binding.pry
    redirect_to root_path
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
