require 'rails_helper'

feature 'User register recipe' do
  let(:user) { create(:user) }

  scenario 'Successfully' do
    recipe = create(:recipe)

    login_as user, scope: :user
    visit root_path

    click_on 'Enviar uma receita'

    fill_in 'Título', with: recipe.title
    select recipe.recipe_type.name, from: 'Tipo da Receita'
    select recipe.cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: recipe.difficulty
    fill_in 'Tempo de Preparo', with: recipe.cook_time
    fill_in 'Ingredientes', with: recipe.ingredients
    fill_in 'Modo de Preparo', with: recipe.cook_method
    attach_file 'Foto', "#{::Rails.root}/spec/support/recipe1.jpg"
    click_on 'Enviar'

    expect(page).to have_css('p', text: "Receita enviada por #{user.email}")
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

  scenario 'and must fill in all fields' do
    login_as user, scope: :user
    visit root_path

    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Modo de Preparo', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Você deve informar todos os dados da receita'
  end

  scenario 'but need to be authenticated to view link' do
    visit root_path

    expect(page).to have_no_css 'a', text: 'Enviar uma receita'
  end

  scenario 'and must be logged to access from url' do 
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end
end
