class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user

  has_one_attached :recipe_photo

  validates :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time,
            :ingredients, :cook_method, presence: true

  enum status: [:pending, :rejected, :approved]
end
