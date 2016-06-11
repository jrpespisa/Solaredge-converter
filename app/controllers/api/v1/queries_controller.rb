class Api::V1::QueriesController < ActionController::Base
  # before_action :authenticate_user!
  def index
    @queries = Query.all
    render json: @queries
  end

  def create
    @query = Query.new(query_params)
    if @query.save
      render json: @query
    else
      render json: :nothing, status: :not_found
    end
  end

  def destroy
    @query = Query.find(params[:id])
    if @query.destroy
      render json: :success
    else
      render json: :nothing, status: :not_found
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
