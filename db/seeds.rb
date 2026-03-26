# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Destroying old data..."
Review.destroy_all
Restaurant.destroy_all

puts "Planting 12 realistic restaurants..."

# Realistic Data Pools
names = [
  "Sora Sushi", "The Pasta Project", "Boulangerie Louise", "Dim Sum House",
  "La Mer Seafood", "Udon Kitchen", "Trattoria Milano", "Peking Garden",
  "Le Petit Bistro", "Waffle Factory", "Sakura Zen", "The Belgian Bear"
]

addresses = [
  "75001 Rue de Rivoli, Paris", "1010 Ginza Crossing, Tokyo", "Soho High St, London",
  "Lower East Side, New York", "Grand Place 5, Brussels", "Via Roma 12, Milan",
  "Bund 18, Shanghai", "Capitol Hill, Seattle", "Quarter Latin, Paris",
  "Shibuya Lane, Tokyo", "Chelsea Market, NY", "St Catherine St, Brussels"
]

# Create the 12 Restaurants
12.times do |i|
  # We use the index 'i' to pick from our realistic arrays
  category = [ "chinese", "italian", "japanese", "french", "belgian" ].sample

  res = Restaurant.create!(
    name: names[i],
    address: addresses[i],
    phone_number: "0#{rand(1..9)} #{rand(10..99)} #{rand(10..99)} #{rand(10..99)}",
    category: category
  )
  puts "📍 Created #{res.name} (#{res.category})"

  # Add 4-8 reviews per restaurant for a "busy" feel
  rand(4..8).times do
    Review.create!(
      rating: rand(2..5), # Keeping ratings high for a 'successful' look
      content: [
        "The atmosphere was incredible, definitely coming back.",
        "Best #{category} food I've had in years. Highly recommend the chef's special.",
        "A hidden gem! The service was attentive and the flavors were spot on.",
        "Perfect for a date night. Make sure to book in advance.",
        "Authentic flavors and a great wine list. 5 stars!",
        "The #{res.category} decor is beautiful. Food is solid."
      ].sample,
      restaurant: res
    )
  end
end

puts "✅ Seeded 12 restaurants with realistic reviews."
