require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Cookbook')
  end

  scenario 'and view recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')

    recipe = Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Média',
                            cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                            cook_method: 'misture tudo e coloque no forno', status: 'approved')

    visit root_path

    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: recipe.cook_time)
  end

  scenario "and don't see pending recipes" do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')

    recipe_x = Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                              cuisine: cuisine, difficulty: 'Média',
                              cook_time: '30', ingredients: 'farinha, ovo, cenoura',
                              cook_method: 'misture tudo e coloque no forno')
          
    recipe_y = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                             ingredients: 'Farinha, berinjela e sal',
                             cook_method: 'Misture tudo e coloque no forno', status: 'approved')

    visit root_path
    
    expect(page).to have_no_text 'Bolo de cenoura'

    expect(page).to have_css('h3', text: recipe_y.title)
    expect(page).to have_css('li', text: recipe_y.recipe_type.name)
    expect(page).to have_css('li', text: recipe_y.cuisine.name)
    expect(page).to have_css('li', text: recipe_y.difficulty)
    expect(page).to have_css('li', text: recipe_y.cook_time)
  end
end
