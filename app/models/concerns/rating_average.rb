module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    self.ratings.map { |r| r.score}.reduce(:+) / self.ratings.count.to_f
  end
end
