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
end