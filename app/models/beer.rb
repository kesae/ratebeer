class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        self.ratings.map { |r| r.score}.reduce(:+) / self.ratings.count.to_f
    end

    def to_s
        "#{self.name}, #{self.brewery.name}"
    end
end
