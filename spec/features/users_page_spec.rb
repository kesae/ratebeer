require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "Wrong1")


      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end
  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end

describe "User Page" do
  let(:user) { FactoryBot.create(:user) }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "contains only the user's ratings" do
    user2 = FactoryBot.create(:user, username: "Vilma")
    ratings = create_many(:rating, {user: user}, {score: [11,12,13,14]})
    ratings2 = create_many(:rating, {user: user2}, {score: [21,22,23,24]})
    visit user_path(user)
    ratings.each do |rating|
      expect(page).to have_content rating.to_s
    end
    ratings2.each do |rating|
      expect(page).not_to have_content rating.to_s
    end
  end

end
