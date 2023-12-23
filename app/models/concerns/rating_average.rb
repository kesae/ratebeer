module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return 0.0 if ratings.empty?

    rating_count = ratings.size
    ratings.map(&:score).sum / rating_count
  end
end
