class Category < ApplicationRecord
  has_many :lists

  validates_presence_of :name
  validates_length_of :name, in: 3..15
end
