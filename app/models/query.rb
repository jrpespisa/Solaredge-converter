class Query < ActiveRecord::Base

  validates :kwh_rate, presence: true
  validates :kwh_credit, presence: true
  validates :kwh_generated, presence: true
  # validates :consumed, presence: true
  validates :sent_to_grid, presence: true
  # validates :savings_consumed, presence: true
  # validates :credit_grid, presence: true
  # validates :savings_before_distribution, presence: true
  validates :distribution_charge, presence: true
  # validates :total_savings, presence: true
end
