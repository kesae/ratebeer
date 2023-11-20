class User < ApplicationRecord
  include RatingAverage

  validates :username, uniqueness: true
  validates :username, length: { in: 3..30 }

  has_many :ratings
end
