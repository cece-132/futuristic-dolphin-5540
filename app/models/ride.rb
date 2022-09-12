class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :maintenances
  has_many :mechanics, through: :maintenances

  validates_presence_of :name
  validates_presence_of :thrill_rating
  validates :open, inclusion: [true, false]

  def self.open_rides
    where(open: :true)
  end

  def self.order_by_thrill
    order(thrill_rating: :desc)
  end

  def self.average_amusement_rating
    average(:thrill_rating)
  end
  

end