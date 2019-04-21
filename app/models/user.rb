class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :lists

  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, minimum: 2
  validates_length_of :last_name, minimum: 2

  def full_name
    "#{first_name} #{last_name}"
  end
end
