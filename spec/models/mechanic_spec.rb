require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :years_experience}
    it { should validate_numericality_of(:years_experience) }
  end

  describe 'relationships' do
    it { should have_many(:maintenances) }
    it { should have_many(:rides).through(:maintenances) }
  end

  describe 'class methods' do
    describe ".avg_experince" do
      it ' calculates the average years' do
        mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
        mech2 = Mechanic.create!(name: 'Jimmy Sole', years_experience: 27)
        mech3 = Mechanic.create!(name: 'Courtney Howel', years_experience: 33)
        mech4 = Mechanic.create!(name: 'John Peter', years_experience: 17)

        expect(Mechanic.avg_experience).to eq(22)
      end
    end
  end

  describe 'instance methods' do
    describe "#maintenance_tickets" do
      it 'Should list the names of the maintenance rides' do
        mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)

        park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
  
        ride1 = Ride.create!( name: 'The Hurler', thrill_rating: 7, open: true, amusement_park_id: park.id)
        ride2 = Ride.create!( name: 'The Patrick', thrill_rating: 5, open: true, amusement_park_id: park.id)
        ride3 = Ride.create!( name: 'The Turner', thrill_rating: 10, open: true, amusement_park_id: park.id)
        ride4 = Ride.create!( name: 'The Squidward', thrill_rating: 7, open: true, amusement_park_id: park.id)
  
        maintenance1 = Maintenance.create!(ride_id: ride1.id, mechanic_id: mech1.id)
        maintenance2 = Maintenance.create!(ride_id: ride2.id, mechanic_id: mech1.id)
        maintenance3 = Maintenance.create!(ride_id: ride3.id, mechanic_id: mech1.id)
        maintenance4 = Maintenance.create!(ride_id: ride4.id, mechanic_id: mech1.id)

        expect(mech1.maintenance_tickets).to eq([ride1, ride2, ride3, ride4])
      end
    end
  end

end