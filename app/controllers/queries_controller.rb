class QueriesController < ApplicationController
  def index
    @totals = Total.all
    @queries = Query.all
    @query = Query.new
  end

  def create
    @queries = Query.all
    @query = Query.new(query_params)
    @query.user = current_user
    if @query.valid?
      QueryCalculator.calculate(@query)
      @query.save
      TotalCalculator.calculate(@queries, current_user)
      redirect_to root_path
    else
      flash[:notice] = "Please enter valid information."
      render :index
    end
  end

  private

  def query_params
    params.require(:query).permit(
    :start_date,
    :end_date,
    :kwh_rate,
    :kwh_credit,
    :sent_to_grid,
    :distribution_charge,
    :user_id
    )
  end
end
