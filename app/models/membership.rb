class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  def to_s
    beer_club.name
  end
end
