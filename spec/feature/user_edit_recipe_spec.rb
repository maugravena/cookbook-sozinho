require 'rails_helper'

feature 'User edit recipe' do
  scenario 'Successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create!(title: 'Bolodecenoura', recipe_type: recipe_type,
                   cuisine: 'Brasileira', difficulty: 'Média',
                   cook_time: 30, ingredients: 'farinha, ovo, cenoura',
                   cook_method: 'Misture tudo e coloque no forno')

    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Média'
    fill_in 'Tempo de Preparo', with: 30
    fill_in 'Ingredientes', with: 'farinha, ovo, cenoura'
    fill_in 'Modo de Preparo', with: 'Misture tudo e coloque no forno'
    click_on 'Enviar'

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Média')
    expect(page).to have_css('p', text: '30 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'farinha, ovo, cenoura')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Misture tudo e coloque no forno')
  end
end
