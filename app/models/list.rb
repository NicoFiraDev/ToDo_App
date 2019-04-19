class List < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :user_id, presence: true
end
