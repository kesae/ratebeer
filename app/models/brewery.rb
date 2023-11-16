class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers
    def average_rating
        self.ratings.map { |r| r.score}.reduce(:+) / self.ratings.count.to_f
    end
end
