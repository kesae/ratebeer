class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*[0-9])/, message: "must contain at least one number and uppercase letter" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end
