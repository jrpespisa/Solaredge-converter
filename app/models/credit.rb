class Credit < ActiveRecord::Base
  belongs_to :user

  validates :tax_credit, numericality: true
  validates :srec_credit, numericality: true
end
