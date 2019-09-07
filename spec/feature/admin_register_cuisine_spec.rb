require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_text 'Cozinha enviada com sucesso'
    expect(current_path).to eq root_path 
  end
  
  scenario 'and the name must be required' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_text 'Campo Obrigatório'
    expect(current_path).to eq cuisines_path
  end

  scenario 'and the name must be unique' do
    User.create(email: 'admin@email.com', password: '123456', admin: true)
    Cuisine.create(name: 'Brasileira')

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    click_on 'Enviar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_text 'Essa cozinha já existe'
    expect(current_path).to eq cuisines_path
  end
end