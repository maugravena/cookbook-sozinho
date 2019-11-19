require 'rails_helper'

feature 'User edit recipe' do
  let(:user) { create(:user) }

  scenario 'Successfully' do
    recipe = create(:recipe, user: user, status: :approved)

    login_as user, scope: :user
    visit root_path

    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Título atualizado'
    select recipe.recipe_type.name, from: 'Tipo da Receita'
    select recipe.cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: recipe.difficulty 
    fill_in 'Tempo de Preparo', with: recipe.cook_time
    fill_in 'Ingredientes', with: recipe.ingredients
    fill_in 'Modo de Preparo', with: recipe.cook_method
    click_on 'Enviar'

    expect(page).to have_text 'Receita atualizada com sucesso'
    expect(page).to have_css('h3', text: 'Título atualizado')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: recipe.cook_method)
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.cook_method)
  end

  scenario 'show button to owner only' do
    other_user = create(:user, email: 'other_user@email.com')
    recipe = create(:recipe, status: :approved)

    login_as other_user, scope: user
    visit root_path

    click_on recipe.title

    expect(page).to have_no_link 'Editar'
  end
end
