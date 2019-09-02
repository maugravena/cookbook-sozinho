require 'rails_helper'

feature 'User a search recipe' do
  scenario 'by exact name and find' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                            cook_method: 'misture tudo e coloque no forno')
    other_recipe = Recipe.create(title: 'Torta de maça', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, maça',
                            cook_method: 'misture tudo e coloque no forno')

    visit root_path

    fill_in 'Buscar receita:', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h3', text: 'Torta de maça')
  end

  scenario "by exact name and don't find" do
    visit root_path

    fill_in 'Buscar receita:', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    expect(page).not_to have_css('h3', text: 'Bolo de cenoura')
  end

  scenario 'by partial name and find more than one' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                            cook_method: 'misture tudo e coloque no forno')

    other_recipe = Recipe.create(title: 'Bolo de maça', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, maça',
                            cook_method: 'misture tudo e coloque no forno')

    visit root_path

    fill_in 'Buscar receita:', with: 'Bolo'
    click_on 'Pesquisar'

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Bolo de maça')
  end
end
