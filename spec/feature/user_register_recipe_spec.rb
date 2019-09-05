require 'rails_helper'

feature 'User register recipe' do
  scenario 'Successfully' do
    recipe_type = RecipeType.create(name: 'Salgada')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@email.com', password: '123456')
    recipe = Recipe.create(user: user, title: 'Torta de Berinjela', recipe_type: recipe_type,
              cuisine: cuisine, difficulty: 'Média', cook_time: 20,
              ingredients: 'Farinha, berinjela e sal',
              cook_method: 'Misture tudo e coloque no forno')

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar uma receita'

    fill_in 'Título', with: recipe.title
    select recipe.recipe_type.name, from: 'Tipo da Receita'
    select recipe.cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: recipe.difficulty
    fill_in 'Tempo de Preparo', with: recipe.cook_time
    fill_in 'Ingredientes', with: recipe.ingredients
    fill_in 'Modo de Preparo', with: recipe.cook_method
    click_on 'Enviar'

    expect(page).to have_css('p', text: "Receita enviada por email@email.com")
    expect(page).to have_css('h3', text: 'Torta de Berinjela')
    expect(page).to have_css('p', text: 'Salgada')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Média')
    expect(page).to have_css('p', text: '20 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha, berinjela e sal')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Misture tudo e coloque no forno')
  end

  scenario 'and must fill in all fields' do
    RecipeType.create(name: 'Salgada')
    Cuisine.create(name: 'Brasileira')
    User.create(email: 'email@email.com', password: '123456')
    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    select '', from: 'Tipo da Receita'
    select '', from: 'Cozinha'
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Modo de Preparo', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Você deve informar todos os dados da receita'
  end

  scenario 'but need to be authenticated' do
    visit root_path

    expect(page).to have_no_css 'a', text: 'Enviar uma receita'
  end
end
