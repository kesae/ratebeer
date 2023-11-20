class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, presence: true
  validates :year, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 1040 }
  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
    return unless year.present? && year.to_i > Time.now.year

    errors.add(:year, "can't be in the future")
  end
end
