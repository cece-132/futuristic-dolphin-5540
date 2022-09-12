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
end