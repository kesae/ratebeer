class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style
  validates :name, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end

  def self.top(number)
    Beer.all.sort_by(&:average_rating).reverse.first(number)
  end
end
