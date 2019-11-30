class Cuisine < ApplicationRecord
  has_many :recipe, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
end
