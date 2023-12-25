json.extract! beer, :name
json.style beer.style.name
json.brewery beer.brewery.name
json.url beer_url(beer, format: :json)
