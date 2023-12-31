class Rating < ApplicationRecord
  belongs_to :beer
  has_one :brewery, through: :beers
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
    "#{beer.name} #{score}"
  end

  def last(count)
    Rating.all.sort_by(&:updated_at).reverse.first(count)
  end
end
