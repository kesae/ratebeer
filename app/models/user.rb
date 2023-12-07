class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*[0-9])/, message: "must contain at least one number and uppercase letter" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :breweries, through: :beers
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    beers.group(:style).order(Arel.sql("avg(score) desc")).first.style
  end

  def favorite_brewery
    return nil if ratings.empty?

    # beer_id = ratings.group(:beer_id).order(Arel.sql("avg(score) desc")).first.beer_id
    # Beer.find_by id: beer_id
    breweries.group(:name).order(Arel.sql("avg(score) desc")).first
  end
end
