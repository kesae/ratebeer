module TopRatings
  extend ActiveSupport::Concern
  def top(number)
    all.sort_by(&:average_rating).reverse.first(number)
  end
end
