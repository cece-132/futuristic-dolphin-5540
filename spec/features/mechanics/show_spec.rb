require 'rails_helper'

RSpec.describe Mechanic do
  describe 'User Story 2' do
    it 'should show all the mechanic info' do
      Maintenance.destroy_all
      Mechanic.destroy_all
      AmusementPark.destroy_all
      Ride.destroy_all

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

      visit mechanics_path

      within ".mechanics" do
        within "#mechanic-#{mech1.id}" do
          click_link "#{mech1.name}"
        end
      end

      expect(current_path).to eq mechanic_path(mech1)
      expect(page).to have_content("#{mech1.name} Information Page")

      within "#mechanic-#{mech1.id}" do
        expect(page).to have_content("#{mech1.name}")
        expect(page).to have_content("#{mech1.years_experience}")
        expect(page).to have_content("#{ride1.name}")
        expect(page).to have_content("#{ride2.name}")
        expect(page).to have_content("#{ride3.name}")
        expect(page).to have_content("#{ride4.name}")
      end

    end

    it 'should show only the rides that are open' do
      Maintenance.destroy_all
      Mechanic.destroy_all
      AmusementPark.destroy_all
      Ride.destroy_all

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

      visit mechanic_path(mech1)

      within "#mechanic-#{mech1.id}" do
        expect(page).to have_content("#{mech1.name}")
        expect(page).to have_content("#{mech1.years_experience}")
        expect(page).to_not have_content("#{ride1.name}")
        expect(page).to have_content("#{ride2.name}")
        expect(page).to have_content("#{ride3.name}")
        expect(page).to have_content("#{ride4.name}")
      end
    end
    it 'should order the rides from most thrills to least thrills' 
  end
end