FactoryBot.define do
  factory :ebook do
    title { Faker::Book.title }
    author { Faker::Book.author }
    description { Faker::Lorem.paragraph }
    published_at { Faker::Date.backward(days: 1000) }

    after(:build) do |ebook|
      ebook.cover_image.attach(
        Rack::Test::UploadedFile.new(
          Rails.root.join("spec/fixtures/files/cover.jpg"),
          "image/jpeg"
        )
      )

      ebook.pdf_file.attach(
        Rack::Test::UploadedFile.new(
          Rails.root.join("spec/fixtures/files/sample.pdf"),
          "application/pdf"
        )
      )
    end
  end
end