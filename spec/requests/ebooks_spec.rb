require "rails_helper"

RSpec.describe "Ebooks", type: :request do
  let!(:ebook) { create(:ebook) }

  describe "GET /ebooks" do
    it "returns success" do
      get ebooks_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /ebooks/:id" do
    it "returns success" do
      get ebook_path(ebook)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /ebooks/new" do
    it "returns success" do
      get new_ebook_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /ebooks/:id/edit" do
    it "returns success" do
      get edit_ebook_path(ebook)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /ebooks" do
    it "creates a new ebook" do
      expect do
        post ebooks_path, params: {
          ebook: {
            title: "Ruby on Rails",
            author: "Dheeraj",
            description: "Testing Ebook",
            published_at: Date.today,
            cover_image: fixture_file_upload(
              Rails.root.join("spec/fixtures/files/cover.jpg"),
              "image/jpeg"
            ),
            pdf_file: fixture_file_upload(
              Rails.root.join("spec/fixtures/files/sample.pdf"),
              "application/pdf"
            )
          }
        }
      end.to change(Ebook, :count).by(1)

      expect(response).to redirect_to(ebooks_path)
    end
  end

  describe "PATCH /ebooks/:id" do
    it "updates the ebook" do
      patch ebook_path(ebook), params: {
        ebook: {
          title: "Updated Title"
        }
      }

      expect(response).to redirect_to(ebook_path(ebook))

      ebook.reload

      expect(ebook.title).to eq("Updated Title")
    end
  end

  describe "DELETE /ebooks/:id" do
    it "deletes the ebook" do
      expect do
        delete ebook_path(ebook)
      end.to change(Ebook, :count).by(-1)

      expect(response).to redirect_to(ebooks_path)
    end
  end

  describe "GET /ebooks/:id/read" do
    it "redirects to pdf" do
      get read_ebook_path(ebook)

      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /ebooks/:id/download" do
    it "redirects to download pdf" do
      get download_ebook_path(ebook)

      expect(response).to have_http_status(:redirect)
    end
  end
end