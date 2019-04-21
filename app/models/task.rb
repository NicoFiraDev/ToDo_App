class Task < ApplicationRecord
  belongs_to :list

  validates_presence_of :body, :list_id
  validates_length_of :body, minimum: 3
end
