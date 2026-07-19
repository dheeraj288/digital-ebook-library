# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Ebook.destroy_all

puts "Creating ebooks..."

cover_path = Rails.root.join("db/seeds/cover.jpg")
pdf_path   = Rails.root.join("db/seeds/sample.pdf")

10.times do |i|
  ebook = Ebook.new(
    title: "Ruby on Rails Guide #{i + 1}",
    author: "Author #{i + 1}",
    description: "This is a sample ebook used for development and testing.",
    published_at: Date.today - rand(1000).days
  )

  if File.exist?(cover_path)
    ebook.cover_image.attach(
      io: File.open(cover_path),
      filename: "cover.jpg",
      content_type: "image/jpeg"
    )
  end

  if File.exist?(pdf_path)
    ebook.pdf_file.attach(
      io: File.open(pdf_path),
      filename: "sample.pdf",
      content_type: "application/pdf"
    )
  end

  ebook.save!
end

puts "✅ Seed completed!"