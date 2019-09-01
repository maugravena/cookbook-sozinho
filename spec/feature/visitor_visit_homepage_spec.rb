require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Cookbook')
  end

  scenario 'and view recipe' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                        cuisine: 'Brasileira', difficulty: 'Média',
                        cook_time: '30')

    visit root_path

    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: recipe.cook_time)
  end
end
