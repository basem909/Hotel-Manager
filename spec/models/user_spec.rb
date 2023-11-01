require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'has a default role of "user"' do
    user = create(:user) # Assuming you have a User factory
    expect(user.role).to eq('user')
  end

  it 'can be assigned the role "admin"' do
    user = build(:user, role: 'admin')
    expect(user).to be_valid
  end

  it 'is not valid with an invalid role' do
    user = build(:user, role: 'invalid_role')
    expect(user).to_not be_valid
  end

  it 'can check if the user has the "admin" role' do
    user = create(:user, role: 'admin')
    expect(user.admin?).to eq(true)
  end
end
