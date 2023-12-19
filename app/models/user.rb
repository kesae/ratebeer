class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*[0-9])/, message: "must contain at least one number and uppercase letter" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :styles, through: :beers
  has_many :breweries, through: :beers
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    # beers.group(:style).order(Arel.sql("avg(score) desc")).select(:style).first.style
    styles.group(:id).order(Arel.sql("avg(score) desc")).first
  end

  def favorite_brewery
    return nil if ratings.empty?

    breweries.group(:id).order(Arel.sql("avg(score) desc")).first
  end

  def self.top(number)
    User.all.sort_by{ |u| u.ratings.count }.reverse.first(number)
  end
end
