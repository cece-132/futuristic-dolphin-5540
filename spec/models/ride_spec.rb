require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
  end

  describe 'relationships' do
    it { should have_many(:maintenances) }
    it { should have_many(:mechanics).through(:maintenance) }
  end
end