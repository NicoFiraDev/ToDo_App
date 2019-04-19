class Category < ApplicationRecord
  has_many :lists
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
end
