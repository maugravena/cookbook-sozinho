class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user

  validates :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time,
            :ingredients, :cook_method, presence: true
end
