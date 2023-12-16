require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    current_weather("kumpula")
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if returned by the API, are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [
        Place.new( name: "Oljenkorsi", id: 1 ),
        Place.new( name: "Kronikka", id: 2 )
      ]
    )
    current_weather("helsinki")
    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kronikka"
  end
  it "if no locations returned by the API, tells it in a notice" do
    place = "oulu"
    allow(BeermappingApi).to receive(:places_in).with(place).and_return([])
    current_weather(place)
    visit places_path
    fill_in('city', with: place)
    click_button "Search"
    expect(find("#notice")).to have_content "No locations in #{place}"
  end
end
