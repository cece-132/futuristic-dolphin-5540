class Maintenance < ApplicationRecord
  belongs_to :ride
  belongs_to :mechanic
end