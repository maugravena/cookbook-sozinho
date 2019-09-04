require 'rails_helper'

feature 'User authenticates to the site' do
  scenario 'succesfully' do
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end
end
