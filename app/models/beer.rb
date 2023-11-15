class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        self.ratings.map { |r| r.score}.reduce(:+) / self.ratings.count.to_f
    end
end
