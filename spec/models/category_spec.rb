require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Association' do
    it { should have_many(:lists) }
  end

  describe 'Validation' do
    subject { Category.new(name: 'abc') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      should validate_presence_of(:name)
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with name length less than 3' do
      should validate_length_of(:name).is_at_least(3)
      subject.name = 'ab'
      expect(subject).to_not be_valid
    end

    it 'is not valid with name length more than 15' do
      should validate_length_of(:name).is_at_most(15)
      subject.name = 'a' * 16
      expect(subject).to_not be_valid
    end
  end
end
