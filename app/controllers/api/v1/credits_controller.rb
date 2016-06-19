class Api::V1::CreditsController < ActionController::Base
  before_action :authenticate_user!

  def index
    @credits = Credit.where('user_id = ?', current_user.id)
    render json: @credits
  end

  def create
    @credit = Credit.new(credit_params)
    @credit.user = current_user
    if @credit.save
      render json: @credit
    else
      render json: :nothing, status: :not_found
    end
  end

  def destroy
    @credit = Credit.find(params[:id])
    if @credit.destroy
      render json: :success
    else
      render json: :nothing, status: :not_found
    end
  end

  private

  def credit_params
    params.require(:credit).permit(
    :tax_credit,
    :srec_credit,
    :user_id
    )
  end
end
