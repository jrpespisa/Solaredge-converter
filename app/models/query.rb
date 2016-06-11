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

  after_save :get_data, :calculate

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
