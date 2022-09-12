class Mechanic < ApplicationRecord
  validates_presence_of :name
  validates :years_experience, presence: true, numericality: { only_integer: true }

  has_many :maintenances
  has_many :rides, through: :maintenances
end