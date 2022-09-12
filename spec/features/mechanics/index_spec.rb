require 'rails_helper'

RSpec.describe Mechanic do
  describe 'User Story 1' do
    it 'should list all mechanics' do
      mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
      mech2 = Mechanic.create!(name: 'Jimmy Sole', years_experience: 27)
      mech3 = Mechanic.create!(name: 'Courtney Howel', years_experience: 33)
      mech4 = Mechanic.create!(name: 'John Peter', years_experience: 17)

      visit mechanics_path

      expect(page).to have_content("All Mechanics")

      within ".mechanics" do
        expect(page).to have_link("#{mech1.name}")
        expect(page).to have_link("#{mech2.name}")
        expect(page).to have_link("#{mech3.name}")
        expect(page).to have_link("#{mech4.name}")
      end

      within ".mechanics" do
        within "#mechanic-#{mech1.id}" do
          expect(page).to have_link("#{mech1.name}")
          expect(page).to have_content("#{mech1.years_experience} years experience")
        end
      end
    end
    it 'should have the average years of experience across all mechanics' do
      mech1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
      mech2 = Mechanic.create!(name: 'Jimmy Sole', years_experience: 27)
      mech3 = Mechanic.create!(name: 'Courtney Howel', years_experience: 33)
      mech4 = Mechanic.create!(name: 'John Peter', years_experience: 17)

      visit mechanics_path

      expect(page).to have_content("Average Years of Experience: 22")
    end
  end
end