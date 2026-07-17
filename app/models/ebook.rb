class Ebook < ApplicationRecord
  has_one_attached :pdf_file
  has_one_attached :cover_image

  validates :title, presence: true
  validates :author, presence: true
  validates :pdf_file, presence: true
end