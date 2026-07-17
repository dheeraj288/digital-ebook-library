class EbooksController < ApplicationController
  before_action :set_ebook, only: %i[
    show
    edit
    update
    destroy
    read
    download
  ]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def read
  end

  def download
  end

  def search
  end

  private

  def set_ebook
    @ebook = Ebook.find(params[:id])
  end

  def ebook_params
    params.require(:ebook).permit(
      :title,
      :author,
      :description,
      :published_at,
      :cover_image,
      :pdf_file
    )
  end
end