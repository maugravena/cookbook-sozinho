class Cuisine < ApplicationRecord
  has_many :recipe
  validates :name, presence: true
  validates :name, uniqueness: true
end
