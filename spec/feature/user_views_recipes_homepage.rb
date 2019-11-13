require 'rails_helper'

feature 'User views recipes in homepage' do
  scanario 'successfully' do
    user = User.create(email: 'email@email.com', password: '123456')
    visit root_path
  end
end
