class Ebook < ApplicationRecord
  has_one_attached :cover_image
  has_one_attached :pdf_file

  validates :title, :author, :description, :published_at, presence: true
  validate :cover_image_validation
  validate :pdf_file_validation

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

  private

  def cover_image_validation
    unless cover_image.attached?
      errors.add(:cover_image, "must be attached")
      return
    end

    unless cover_image.content_type.in?(%w[
      image/jpeg
      image/png
      image/webp
    ])
      errors.add(:cover_image, "must be a JPG, PNG or WEBP image")
    end

    if cover_image.blob.byte_size > 5.megabytes
      errors.add(:cover_image, "must be smaller than 5 MB")
    end
  end

  def pdf_file_validation
    unless pdf_file.attached?
      errors.add(:pdf_file, "must be attached")
      return
    end

    unless pdf_file.content_type == "application/pdf"
      errors.add(:pdf_file, "must be a PDF")
    end

    if pdf_file.blob.byte_size > 20.megabytes
      errors.add(:pdf_file, "must be smaller than 20 MB")
    end
  end
end