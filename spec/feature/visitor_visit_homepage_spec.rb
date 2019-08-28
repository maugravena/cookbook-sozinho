require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'Successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Cookbook')
  end
end
