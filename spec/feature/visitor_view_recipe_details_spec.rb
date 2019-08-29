require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'Successfully' do
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
                        cuisine: 'Brasileira', difficulty: 'Média',
                        cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                        cook_method: 'misture tudo e coloque no forno')

    visit root_path

    click_on 'Bolo de cenoura'

    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type)
    expect(page).to have_css('p', text: recipe.cuisine)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: recipe.cook_time)

    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)

    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.cook_method)
  end
end
