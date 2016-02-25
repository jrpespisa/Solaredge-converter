class QueryCalculator
  def self.calculate(query)
    @query = query
    solar_data = SolarData.new(@query.start_date, @query.end_date)
    @query.kwh_generated =  solar_data.solar_total / 1000
    @query.consumed = @query.kwh_generated - @query.sent_to_grid
    @query.savings_consumed = @query.consumed * @query.kwh_rate
    @query.credit_grid = @query.sent_to_grid * @query.kwh_credit
    @query.savings_before_distribution = @query.savings_consumed + @query.credit_grid
    @query.total_savings = @query.savings_before_distribution - @query.distribution_charge
  end
end
