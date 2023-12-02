require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with a brewery" do
    let(:brewery) { Brewery.create name: "Brew", year: 2000}
    it "and with a name and style, is created" do
      beer = Beer.new name: "Beer", style: "Lager", brewery_id: brewery.id

      expect(beer.nil?).to be(false)
    end
    it "and with a name and style, is saved" do
      beer = Beer.create name: "Beer", style: "Lager", brewery_id: brewery.id

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
    it "is not saved without a name" do
      beer = Beer.create style: "Lager", brewery_id: brewery.id

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
    it "is not saved without a style" do
      beer = Beer.create name: 'Beer', brewery_id: brewery.id

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
