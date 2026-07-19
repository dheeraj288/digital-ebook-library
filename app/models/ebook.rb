class Ebook < ApplicationRecord
  has_one_attached :cover_image
  has_one_attached :pdf_file

  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :published_at, presence: true
  validates :cover_image, presence: true
  validates :pdf_file, presence: true

  scope :recent, -> { order(created_at: :desc) }

  scope :search, ->(query) do
    return all if query.blank?

    where(
      "title ILIKE :query OR author ILIKE :query",
      query: "%#{query}%"
    )
  end

  scope :filter_by_author, ->(author) do
    return all if author.blank?

    where(author: author)
  end

  scope :filter_by_year, ->(year) do
    return all if year.blank?

    where("EXTRACT(YEAR FROM published_at) = ?", year.to_i)
  end

  scope :sort_by_option, ->(sort) do
    case sort
    when "newest"
      order(created_at: :desc)
    when "oldest"
      order(created_at: :asc)
    when "title_asc"
      order(title: :asc)
    when "title_desc"
      order(title: :desc)
    else
      order(created_at: :desc)
    end
  end
end