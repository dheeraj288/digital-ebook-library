class Ebook < ApplicationRecord
  has_one_attached :cover_image
  has_one_attached :pdf_file

  validates :title, :author, :description, :published_at, presence: true
  validates :cover_image, :pdf_file, presence: true

  scope :recent, -> { order(created_at: :desc) }

  scope :search, ->(query) {
    if query.present?
      where(
        "title ILIKE :query OR author ILIKE :query",
        query: "%#{query}%"
      )
    end
  }
end