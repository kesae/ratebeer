# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if ActiveRecord::Base.connection.column_exists?(:beers, :old_style)
  Beer.all.each do |beer|
    style = Style.find_or_create_by!(name: beer.old_style, description: "No description yet.")
    beer.style_id = style.id
    beer.save
  end
end

if Brewery.all.map(&:active).all?(nil)
  Brewery.all.first(Brewery.all.size - 1).each do |brewery|
    if brewery.active.nil?
      brewery.active = true
      brewery.save
    end
  end
end

if User.all.map(&:admin).all?(nil)
  user = User.find_by username: "admin"
  user.update_attribute(:admin, true) if user
end
