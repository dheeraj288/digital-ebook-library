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
    @ebooks = Ebook.order(created_at: :desc)
  end

  def show
    @ebook = Ebook.find(params[:id])
  end

  def new
  @ebook = Ebook.new
  end

  def create
    @ebook = Ebook.new(ebook_params)

    if @ebook.save
      redirect_to ebooks_path, notice: "Ebook uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
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