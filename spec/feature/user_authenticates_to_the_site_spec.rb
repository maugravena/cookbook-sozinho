require 'rails_helper'

feature 'User authenticates to the site' do
  scenario 'succesfully' do
    visit root_path
    click_on 'Fazer cadastro'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end

  scenario 'and logout' do
    visit root_path
    click_on 'Fazer cadastro'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    click_on 'Sair'

    expect(page).to have_content I18n.t('devise.sessions.signed_out')
    #expect(page).to have_no_css('a', text: 'Entrar')
    #expect(page).to have_css('a', text: 'Sair')
  end
end
