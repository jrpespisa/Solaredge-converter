class Query < ActiveRecord::Base
  belongs_to :user

  validate :start_date_is_date?
  validate :end_date_is_date?

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :kwh_rate, presence: true, numericality: true
  validates :kwh_credit, presence: true, numericality: true
  validates :sent_to_grid, presence: true, numericality: true
  validates :distribution_charge, presence: true, numericality: true

  before_save :get_data, :calculate

  def get_data
    @key = ENV["API_KEY"]
    @uri = URI("https://monitoringapi.solaredge.com/site/#{self.user.site_id}/energy?timeUnit=DAY&endDate=#{self.end_date}&startDate=#{self.start_date}&api_key=#{@key}")
    @response = Net::HTTP.get_response(@uri)
    @info = JSON.parse(@response.body)
    energy_dates = @info["energy"]["values"]
    @solar_total = energy_dates.map { |date| date["value"] }.reduce(:+)
  end


  def calculate
    self.kwh_generated = @solar_total / 1000
    self.consumed = self.kwh_generated - self.sent_to_grid
    self.savings_consumed = self.consumed * self.kwh_rate
    self.credit_grid = self.sent_to_grid * self.kwh_credit
    self.savings_before_distribution = self.savings_consumed + self.credit_grid
    self.total_savings = self.savings_before_distribution - self.distribution_charge
  end

  def self.process_totals(queries, current_user, credits)
    totals = {
      kwh_generated: 0,
      kwh_consumed: 0,
      savings_consumed: 0,
      sent_to_grid: 0,
      credit_grid: 0,
      savings_before_distribution: 0,
      distribution_charge: 0
    }
    srec = 0
    tax = 0
    credits.each do |credit|
      srec += credit.srec_credit.to_i
      tax += credit.tax_credit.to_i
    end
    credit_total = srec + tax
    queries.each do |query|
      totals[:kwh_generated] += query.kwh_generated
      totals[:kwh_consumed] += query.consumed
      totals[:savings_consumed] += query.savings_consumed
      totals[:sent_to_grid] += query.sent_to_grid
      totals[:credit_grid] += query.credit_grid
      totals[:savings_before_distribution] += query.savings_before_distribution
      totals[:distribution_charge] += query.distribution_charge
    end
    totals[:initial_investment] = current_user.initial_investment
    totals[:savings] = totals[:savings_before_distribution] - totals[:distribution_charge] + credit_total
    totals[:balance] = totals[:initial_investment] - totals[:savings]
    return totals
  end

  def self.response(queries, current_user)
    response = {}
    response["user"] = current_user,
    response["queries"] = queries
    response["totals"] = process_totals(queries, current_user, current_user.credits)
    response["credits"] = current_user.credits
    return response
  end

  private

  def start_date_is_date?
    unless start_date.is_a?(Date)
      errors.add(:start_date, 'must be a valid start date')
    end
  end

  def end_date_is_date?
    unless end_date.is_a?(Date)
      errors.add(:end_date, 'must be a valid end date')
    end
  end
end
