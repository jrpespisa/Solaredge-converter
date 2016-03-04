class User < ActiveRecord::Base
  has_many :queries
  has_many :totals

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :site_id, presence: true, numericality: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
