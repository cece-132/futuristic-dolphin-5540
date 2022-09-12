require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :thrill_rating}
    it { should allow_value(%w(true false)).for(:open) }
  end
  
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many(:maintenances) }
    it { should have_many(:mechanics).through(:maintenances) }
  end
end