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
