class Total < ActiveRecord::Base
  belongs_to :user

  validates :kwh_generated, presence: true, numericality: true
  validates :kwh_consumed, presence: true, numericality: true
  validates :savings_consumed, presence: true, numericality: true
  validates :sent_to_grid, presence: true, numericality: true
  validates :credit_grid, presence: true, numericality: true
  validates :savings_before_distribution, presence: true, numericality: true
  validates :distribution_charge, presence: true, numericality: true
  validates :total_savings, presence: true, numericality: true
end
