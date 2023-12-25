require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end

    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows a known beer", js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "is ordeded by the Name column by default", js:true do
    visit beerlist_path

    rows = find('#datatable').all('.tablerow')
    expect(rows[0]).to have_content "Fastenbier"
    expect(rows[1]).to have_content "Lechte Weisse"
    expect(rows[2]).to have_content "Nikolai"
  end

  it "is ordeded by the Style column when the header is clicked", js:true do
    visit beerlist_path
    find('#style').click

    rows = find('#datatable').all('.tablerow')
    expect(rows[0]).to have_content "Lager"
    expect(rows[1]).to have_content "Rauchbier"
    expect(rows[2]).to have_content "Weizen"
  end

  it "is ordeded by the Brewery column when the header is clicked", js:true do
    visit beerlist_path
    find('#brewery').click

    rows = find('#datatable').all('.tablerow')
    expect(rows[0]).to have_content "Ayinger"
    expect(rows[1]).to have_content "Koff"
    expect(rows[2]).to have_content "Schlenkerla"
  end
end
