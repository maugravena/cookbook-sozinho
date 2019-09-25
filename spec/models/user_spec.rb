require 'rails_helper'

RSpec.describe User, type: :model do
  it 'find by email' do
    user = User.create(email: 'test@email.com', password: '123456')
    find_user = User.find_by_email('test@email.com')

    expect(user).to eq find_user
  end
end
