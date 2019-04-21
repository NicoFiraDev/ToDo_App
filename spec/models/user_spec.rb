require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  setup do
    @user = users(:user_one)
    @user_two = User.new(email: 'test@email.com',
                         password: 'password',
                         first_name: 'User',
                         last_name: 'Test')
  end

  subject { @user }

  describe 'Association' do
    it { should have_many(:lists) }
  end
  
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without email' do
      should validate_presence_of(:email)
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'duplicate email is not valid' do
      should validate_uniqueness_of(:email).case_insensitive
      expect(@user_two).to_not be_valid
    end

    it 'is not valid without first name' do
      should validate_presence_of(:first_name)
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without last name' do
      should validate_presence_of(:last_name)
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with first_name less than 2' do
      should validate_length_of(:first_name).is_at_least(2)
      subject.first_name = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not valid with last_name less than 2' do
      should validate_length_of(:last_name).is_at_least(2)
      subject.last_name = 'a'
      expect(subject).to_not be_valid
    end
  end

  describe 'Methods' do
    it 'returns full name' do
      expect(subject.full_name).to eq('User Test')
    end
  end
end
