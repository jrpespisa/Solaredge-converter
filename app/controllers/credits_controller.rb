class CreditsController < ApplicationController
  def create
    @credits = Credit.all
    @queries = Query.all
    @credit = Credit.new(credit_params)
    @credit.user = current_user
    if @credit.save
      TotalCalculator.calculate(@queries, @credits, current_user)
      redirect_to root_path
    else
      flash[:notice] = "Please enter valid information."
      redirect_to root_path
    end
  end

  def destroy
    @credits = Credit.all
    @queries = Query.all
    @credit = Credit.find(params[:id])
    @credit.user = current_user
    @credit.destroy
    TotalCalculator.calculate(@queries, @credits, current_user)
    redirect_to root_path
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
