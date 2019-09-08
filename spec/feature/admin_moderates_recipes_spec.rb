require 'rails_helper'

feature 'Admin moderates recipes' do
  scenario 'to post' do
    user = User.create(email: 'admin@email.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                   cuisine: cuisine, difficulty: 'Média',
                   cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                   cook_method: 'Misture tudo e coloque no forno')

    Recipe.create(user: user, title: 'Torta de maça', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Média',
                  cook_time: '30', ingredients: 'farinha, ovo, maça',
                  cook_method: 'misture tudo e coloque no forno')
    
    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Receitas pendentes'
    click_on 'Torta de maça'
    
    choose 'recipe_status_approved'
    click_on 'Enviar'

    expect(page).to have_text 'Receita atualizada com sucesso'
    expect(page).to have_text 'approved'
  end

  scenario 'to reject' do
    user = User.create(email: 'admin@email.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    Recipe.create!(user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                   cuisine: cuisine, difficulty: 'Média',
                   cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                   cook_method: 'Misture tudo e coloque no forno')

    Recipe.create(user: user, title: 'Torta de maça', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Média',
                  cook_time: '30', ingredients: 'farinha, ovo, maça',
                  cook_method: 'misture tudo e coloque no forno')
    
    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Receitas pendentes'
    click_on 'Torta de maça'

    choose 'recipe_status_rejected'
    click_on 'Enviar'

    expect(page).to have_text 'Receita atualizada com sucesso'
    expect(page).to have_text 'rejected'
  end
end