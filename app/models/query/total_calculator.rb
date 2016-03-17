class TotalCalculator
  def self.calculate(queries, current_user)
    @queries = queries
    if Total.any?
      Total.destroy_all
    end  
    @total = Total.new
    @queries.each do |query|
      @total.kwh_generated += query.kwh_generated
      @total.kwh_consumed += query.consumed
      @total.savings_consumed += query.savings_consumed
      @total.sent_to_grid += query.sent_to_grid
      @total.credit_grid += query.credit_grid
      @total.savings_before_distribution += query.savings_before_distribution
      @total.distribution_charge += query.distribution_charge
      @total.total_savings += query.total_savings
      @total.user = current_user
    end
    @total.save
  end
end
