require 'rails_helper'

feature 'user views his own recipes' do
  scenario 'successfully' do
    user = User.create(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')

    recipe_x = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Média', cook_time: 20,
                           ingredients: 'Farinha, berinjela e sal',
                           cook_method: 'Misture tudo e coloque no forno')
    
    recipe_y = Recipe.create(user: user, title: 'Bolodecenoura', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Média',
                             cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                             cook_method: 'Misture tudo e coloque no forno')

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Minhas Receitas'

    expect(page).to have_css 'h1', text: "Suas Receitas - #{user.email}"
    expect(page).to have_content recipe_x.title
    expect(page).to have_content recipe_y.title
  end

  scenario 'and must be logged in to view link' do
    visit root_path

    expect(page).to have_no_css 'a', text: 'Mindas Receitas'
  end

  scenario 'and must be logged to access from url' do
    visit user_recipes_path

    expect(current_path).to eq new_user_session_path
  end
end