json.extract! brewery, :id, :name, :year, :active, :created_at, :updated_at
json.beer_count brewery.beers.count
json.url brewery_url(brewery, format: :json)
