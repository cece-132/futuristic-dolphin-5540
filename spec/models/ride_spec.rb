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

  describe '#open_rides' do
    it 'Should sort rides by open status' do
      mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)

      park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      ride1 = Ride.create!( name: 'The Hurler', thrill_rating: 7, open: false, amusement_park_id: park.id)
      ride2 = Ride.create!( name: 'The Patrick', thrill_rating: 5, open: true, amusement_park_id: park.id)
      ride3 = Ride.create!( name: 'The Turner', thrill_rating: 10, open: true, amusement_park_id: park.id)
      ride4 = Ride.create!( name: 'The Squidward', thrill_rating: 7, open: true, amusement_park_id: park.id)

      maintenance1 = Maintenance.create!(ride_id: ride1.id, mechanic_id: mech1.id)
      maintenance2 = Maintenance.create!(ride_id: ride2.id, mechanic_id: mech1.id)
      maintenance3 = Maintenance.create!(ride_id: ride3.id, mechanic_id: mech1.id)
      maintenance4 = Maintenance.create!(ride_id: ride4.id, mechanic_id: mech1.id)

      expect(mech1.maintenance_tickets.open_rides).to eq([ride2, ride3, ride4])
    end
  end

  describe '#order_by_thrill' do
    it 'should order rides by thrill rating' do
      mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)

      park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      ride1 = Ride.create!( name: 'The Hurler', thrill_rating: 7, open: false, amusement_park_id: park.id)
      ride2 = Ride.create!( name: 'The Patrick', thrill_rating: 5, open: true, amusement_park_id: park.id)
      ride3 = Ride.create!( name: 'The Turner', thrill_rating: 10, open: true, amusement_park_id: park.id)
      ride4 = Ride.create!( name: 'The Squidward', thrill_rating: 7, open: true, amusement_park_id: park.id)

      maintenance1 = Maintenance.create!(ride_id: ride1.id, mechanic_id: mech1.id)
      maintenance2 = Maintenance.create!(ride_id: ride2.id, mechanic_id: mech1.id)
      maintenance3 = Maintenance.create!(ride_id: ride3.id, mechanic_id: mech1.id)
      maintenance4 = Maintenance.create!(ride_id: ride4.id, mechanic_id: mech1.id)

      expect(mech1.maintenance_tickets.open_rides.order_by_thrill).to eq([ride3, ride4, ride2])
    end
  end

  describe '.average_amusement_rating' do
    it 'finds the average of the thriller rating' do
      park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      ride1 = Ride.create!( name: 'The Hurler', thrill_rating: 7, open: true, amusement_park_id: park.id)
      ride2 = Ride.create!( name: 'The Patrick', thrill_rating: 5, open: true, amusement_park_id: park.id)
      ride3 = Ride.create!( name: 'The Turner', thrill_rating: 10, open: true, amusement_park_id: park.id)
      ride4 = Ride.create!( name: 'The Squidward', thrill_rating: 7, open: true, amusement_park_id: park.id)

      expect(Ride.average_amusement_rating).to eq 7.25
    end
  end
end