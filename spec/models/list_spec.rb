# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  fixtures :users, :categories

  setup do
    @user = users(:user_one)
    @category = categories(:category_one)
  end

  subject do
    List.new(name: 'abc', user_id: @user.id)
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:category).optional }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      should validate_presence_of(:name)
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it { should_not validate_presence_of(:category_id) }

    it 'is not valid with a length less than 2' do
      should validate_length_of(:name).is_at_least(3)
      subject.name = 'ab'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a length more than 25' do
      should validate_length_of(:name).is_at_most(25)
      subject.name = 'a' * 26
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user_id' do
      should validate_presence_of(:user_id)
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end
