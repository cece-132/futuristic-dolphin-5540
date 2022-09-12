require 'rails_helper'

RSpec.describe Mechanic do
  describe 'EXTENSION' do
    it 'should show all the park info' do
      AmusementPark.destroy_all
      Ride.destroy_all

      park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      ride1 = Ride.create!( name: 'The Hurler', thrill_rating: 7, open: true, amusement_park_id: park.id)
      ride2 = Ride.create!( name: 'The Patrick', thrill_rating: 5, open: true, amusement_park_id: park.id)
      ride3 = Ride.create!( name: 'The Turner', thrill_rating: 10, open: true, amusement_park_id: park.id)
      ride4 = Ride.create!( name: 'The Squidward', thrill_rating: 7, open: true, amusement_park_id: park.id)

      visit amusement_park_path(park)

      expect(page).to have_content("Welcome to #{park.name}")
      expect(page).to have_content("Park: #{park.name}")
      expect(page).to have_content("Admission: $#{park.admission_cost}.00")

      within '.rides' do
        expect(page).to have_content("#{ride1.name}")
        expect(page).to have_content("#{ride2.name}")
        expect(page).to have_content("#{ride3.name}")
        expect(page).to have_content("#{ride4.name}")
      end

      expect(page).to have_content("Average Thrill Rating of Rides: 7.3/10")
    end
  end
end