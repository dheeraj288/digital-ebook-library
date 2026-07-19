require "rails_helper"

RSpec.describe Ebook, type: :model do
  subject(:ebook) { build(:ebook) }

  it "is valid with valid attributes" do
    expect(ebook).to be_valid
  end

  it "requires a title" do
    ebook.title = nil
    expect(ebook).not_to be_valid
  end

  it "requires an author" do
    ebook.author = nil
    expect(ebook).not_to be_valid
  end

  it "requires a description" do
    ebook.description = nil
    expect(ebook).not_to be_valid
  end

  it "requires a published date" do
    ebook.published_at = nil
    expect(ebook).not_to be_valid
  end

  it "requires a cover image" do
    ebook.cover_image.detach
    expect(ebook).not_to be_valid
  end

  it "requires a pdf file" do
    ebook.pdf_file.detach
    expect(ebook).not_to be_valid
  end
end