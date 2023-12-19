require 'rails_helper'

describe "Breweries page" do
  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'
    expect(page).to have_content 'Number of active breweries: 0'
    expect(page).to have_content 'Number of retired breweries: 0'
  end
  it "lists the total number of active and retired breweries" do
    breweries = ["Koff", "Karjala", "Schlenkerla"]
    breweries.each do |brewery_name|
      FactoryBot.create(:brewery, name: brewery_name, active: true)
    end
    FactoryBot.create(:brewery, active: false)
    FactoryBot.create(:brewery)

    visit breweries_path

    expect(page).to have_content "Number of active breweries: #{breweries.count}"
    expect(page).to have_content "Number of retired breweries: 2"

    breweries.each do |brewery_name|
      expect(page).to have_content brewery_name
    end
  end
  it "allows user to navigate to page of a Brewery" do
    breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    breweries.each do |brewery_name|
      FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
    end

    visit breweries_path

    click_link "Koff"

    expect(page).to have_content "Koff"
    expect(page).to have_content "Established in 1897"
  end
end
