require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :lists
  setup { @list = lists(:list_one) }
  subject { Task.new(body: 'abc', list_id: @list.id) }

  describe 'Associations' do
    it { should belong_to(:list) }
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a body' do
      should validate_presence_of(:body)
      subject.body = nil
      expect(subject).to_not be_valid
      subject.body = '       '
      expect(subject).to_not be_valid
    end

    it 'is not valid with a body length less than 3' do
      should validate_length_of(:body).is_at_least(3)
      subject.body = 'ab'
      expect(subject).to_not be_valid
    end

    it 'is not valid without list_id' do
      should validate_presence_of(:list_id)
      subject.list_id = nil
      expect(subject).to_not be_valid
    end
  end
end
