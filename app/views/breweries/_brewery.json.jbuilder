json.extract! brewery, :id, :name, :year
json.beer_count brewery.beers.count
json.status brewery.active || false
json.url brewery_url(brewery, format: :json)
