require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery}
  before :each do
  end


  it "is added when the name is non-empty" do
    visit new_beer_path
    fill_in('beer_name', with: 'nonempty')
    expect{
      click_button('Create Beer')
      }. to change{Beer.count}.by(1)
    end
    it "is not added when the name is empty" do
      visit new_beer_path
      fill_in('beer_name', with: '')
    expect{
      click_button('Create Beer')
    }. not_to change{Beer.count}.from(0)
  end
end
