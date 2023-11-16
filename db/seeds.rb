# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
b1 = Brewery.create name: "Koff", year: 1897
b2 = Brewery.create name: "Malmgard", year: 2001
b3 = Brewery.create name: "Weihenstephaner", year: 1040

beer1 = b1.beers.create name: "Iso 3", style: "Lager"
beer2 = b1.beers.create name: "Karhu", style: "Lager"
beer3 = b1.beers.create name: "Tuplahumala", style: "Lager"
beer4 = b2.beers.create name: "Huvila Pale Ale", style: "Pale Ale"
beer5 = b2.beers.create name: "X Porter", style: "Porter"
beer6 = b3.beers.create name: "Hefeweizen", style: "Weizen"
beer7 = b3.beers.create name: "Helles", style: "Lager"

beer1.ratings.create score: 12
beer1.ratings.create score: 40
beer1.ratings.create score: 30
beer2.ratings.create score: 46
beer2.ratings.create score: 12
beer3.ratings.create score: 22
beer4.ratings.create score: 12
beer4.ratings.create score: 40
beer4.ratings.create score: 30
beer6.ratings.create score: 46
beer6.ratings.create score: 12
beer7.ratings.create score: 22
