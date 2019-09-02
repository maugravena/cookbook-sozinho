require 'rails_helper'

feature 'User can search recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                            cook_method: 'misture tudo e coloque no forno')

    visit root_path

    fill_in 'Buscar receita:', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
  end
end
