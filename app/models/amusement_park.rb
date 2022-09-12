class AmusementPark < ApplicationRecord
  has_many :rides
  
  validates_presence_of :name
  validates :admission_cost, presence: true, numericality: true
  # validates_presence_of :admission_cost, numericality: true
end