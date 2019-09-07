require 'rails_helper'

feature 'Admin register recipe type' do
  scenario 'successfully' do 
    User.create(email: 'admin@email.com', password: '123456', admin: true)

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_text 'Tipo de receita enviado com sucesso'
    expect(current_path).to eq root_path 
  end

  scenario 'and the name must be required' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar tipo de receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_text 'Campo Obrigatório'
    expect(current_path).to eq recipe_types_path
  end

  scenario 'and the name must be unique' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)
    RecipeType.create(name: 'Sobremesa')

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar tipo de receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_text 'Esse tipo de receita já existe'
    expect(current_path).to eq recipe_types_path
  end
end