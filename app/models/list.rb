class List < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :tasks

  validates_presence_of :name, :user_id
  validates_length_of :name, in: 3..25
end
