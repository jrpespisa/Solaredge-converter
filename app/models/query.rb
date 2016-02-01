class Query < ActiveRecord::Base

  validates :kwh_rate, presence: true, numericality: true
  validates :kwh_credit, presence: true, numericality: true
  validates :kwh_generated, presence: true, numericality: true
  validates :sent_to_grid, presence: true, numericality: true
  validates :distribution_charge, presence: true, numericality: true
end
