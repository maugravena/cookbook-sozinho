require 'rails_helper'

feature 'User register recipe' do
  scenario 'Successfully' do
    RecipeType.create(name: 'Salgada')
    Cuisine.create(name: 'Brasileira')
    visit root_path

    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Torta de Berinjela'
    select 'Salgada', from: 'Tipo da Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Média'
    fill_in 'Tempo de Preparo', with: 20
    fill_in 'Ingredientes', with: 'Farinha, berinjela e sal'
    fill_in 'Modo de Preparo', with: 'Misture tudo e coloque no forno'
    click_on 'Enviar'

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
    visit root_path
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
end
