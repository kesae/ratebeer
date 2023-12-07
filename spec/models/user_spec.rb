require 'rails_helper'

def arg_lists_to_hashes(arg_lists)
  hashes = []
  arg_lists.first[1].each_with_index do |_, i|
    hash = {}
    arg_lists.keys.each do |key|
      hash = hash.merge({key => arg_lists[key][i]})
    end
    hashes << hash
  end
  hashes
end

def create_many(type, common_args, arg_lists)
  result = []
  hashes = arg_lists_to_hashes(arg_lists)
  hashes.each do |hash|
    obj = FactoryBot.create(type, common_args.merge(hash))
    result << obj
  end
  result
end


RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short password" do
    user = User.create username: "Pekka", password: "1Aa"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with an all-lowercase password" do
    user = User.create username: "Pekka", password: "longenoughpassword"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
    it "has method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end
    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end
    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end
    it "is the one with highest rating if several rated" do
      create_many(:rating, {user: user,}, {score: [10, 15, 9]} )
      best = FactoryBot.create(:rating, user: user, score: 25).beer

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }
    it "has method for determining the favorite_style" do
      expect(user).to respond_to(:favorite_style)
    end
    it "without ratings does not have a favorite style" do

      expect(user.favorite_style).to eq(nil)
    end
    it "is of the only rated if only one rating" do
      beer = FactoryBot.create(:beer, style: "Porter")
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style).to eq("Porter")
    end
    it "is the style with highest average rating" do
      scores = [10, 30, 40, 50]
      styles = ["Lager", "Porter", "Porter", "Lager"]
      beers = create_many(:beer, {}, {style: styles})
      beers.each_with_index do |beer, i|
        FactoryBot.create(:rating, score: scores[i], beer: beer, user: user)
      end

      expect(user.favorite_style).to eq("Porter")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }
    it "has method for determining the favorite_brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end
    it "without ratings does not have a favorite_brewery" do
      expect(user.favorite_brewery).to eq(nil)
    end
    it "is the one with the rated beer if only one rating" do
      brewery = FactoryBot.create(:brewery, name: "Brews")
      beer = FactoryBot.create(:beer, brewery: brewery)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_brewery).to eq(brewery)
    end
    it "is the brewery with highest average rating" do
      breweries = create_many(:brewery, {}, {name: ["X", "Y", "Z"]} )
      score_lists = [[10, 50], [40, 40], [10,10,10]]
      breweries.each_with_index do |brewery, i|
        names = score_lists[i].map(&:to_s)
        beers = create_many(:beer, {brewery: brewery}, {name: names})
        create_many(:rating, {user: user}, {beer: beers, score: score_lists[i]})
      end

      expect(user.favorite_brewery).to eq(breweries[1])
    end
  end

end
