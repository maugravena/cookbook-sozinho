require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'Successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')

    recipe = Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                            cook_method: 'misture tudo e coloque no forno')
    
    visit root_path
    click_on 'Bolo de cenoura'

    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: recipe.cook_time)
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.cook_method)
  end
end
