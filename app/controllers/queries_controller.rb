class QueriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @totals = Total.all
    @credits = Credit.all
    @credit = Credit.new
    @queries = Query.all
    @query = Query.new
  end

  def create
    @queries = Query.all
    @credits = Credit.all
    @query = Query.new(query_params)
    @query.user = current_user
    if @query.save
      redirect_to root_path
    else
      flash[:notice] = "Please enter valid information."
      render :index
    end
  end

  def destroy
    @queries = Query.all
    @credits = Credit.all
    @query = Query.find(params[:id])
    @query.user = current_user
    @query.destroy
    TotalCalculator.calculate(@queries, @credits, current_user)
    redirect_to root_path
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
