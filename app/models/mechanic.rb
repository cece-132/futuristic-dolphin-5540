class Mechanic < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :years_experience

  has_many :maintenances
  has_many :rides, through: :maintenances
end