class Style < ApplicationRecord
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end

  def self.top(number)
    Style.all.sort_by(&:average_rating).reverse.first(number)
  end
end
