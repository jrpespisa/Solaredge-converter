class TotalCalculator
  def self.calculate(queries, credits, current_user)
    @queries = queries
    @credits = credits
    if Total.any?
      Total.destroy_all
    end
    @total = Total.new
    @total.user = current_user
    @credits.each do |credit|
      if credit.user == current_user
        @total.total_savings += credit.srec_credit + credit.tax_credit
      end
    end
    @queries.each do |query|
      if query.user == current_user
        @total.kwh_generated += query.kwh_generated
        @total.kwh_consumed += query.consumed
        @total.savings_consumed += query.savings_consumed
        @total.sent_to_grid += query.sent_to_grid
        @total.credit_grid += query.credit_grid
        @total.savings_before_distribution += query.savings_before_distribution
        @total.distribution_charge += query.distribution_charge
        @total.total_savings += query.total_savings
      end
    end
    @total.save
  end
end
