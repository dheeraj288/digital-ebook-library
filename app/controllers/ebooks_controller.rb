class EbooksController < ApplicationController
  before_action :set_ebook, only: %i[
    show
    edit
    update
    destroy
  ]

  def index
    @ebooks = Ebook.recent
    @ebooks = @ebooks.search(params[:query]) if params[:query].present?
  end

  def show
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

  def update
    if @ebook.update(ebook_params)
      redirect_to ebook_path(@ebook), notice: "Ebook updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ebook.destroy
    redirect_to ebooks_path, notice: "Ebook deleted successfully."
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