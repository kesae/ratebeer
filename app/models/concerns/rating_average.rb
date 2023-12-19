module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return 0.0 if ratings.empty?

    ratings.map(&:score).reduce(:+) / ratings.count.to_f
  end
end
