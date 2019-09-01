class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
end
