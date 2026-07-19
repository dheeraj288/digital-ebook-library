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
  @query  = params[:query]
  @author = params[:author]
  @year   = params[:year]
  @sort   = params[:sort]

  @ebooks = Ebook
              .search(@query)
              .filter_by_author(@author)
              .filter_by_year(@year)
              .sort_by_option(@sort)

  Rails.logger.debug "Ebooks count: #{@ebooks.count}"

  @authors = Ebook.distinct.order(:author).pluck(:author)
  @years = Ebook.where.not(published_at: nil).pluck(:published_at).map(&:year).uniq.sort.reverse
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

  def edit
  end

  def update
    if @ebook.update(ebook_params)
      redirect_to @ebook, notice: "Ebook updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ebook.destroy

    redirect_to ebooks_path,
                notice: "Ebook deleted successfully."
  end

  def read
    if @ebook.pdf_file.attached?
      redirect_to rails_blob_url(@ebook.pdf_file,
                                 disposition: "inline")
    else
      redirect_to @ebook,
                  alert: "PDF file not found."
    end
  end

  def download
    if @ebook.pdf_file.attached?
      redirect_to rails_blob_url(@ebook.pdf_file,
                                 disposition: "attachment")
    else
      redirect_to @ebook,
                  alert: "PDF file not found."
    end
  end

  def authors
    Ebook.distinct.order(:author).pluck(:author)
  end

  helper_method :authors

  def years
    Ebook
      .where.not(published_at: nil)
      .pluck(:published_at)
      .map(&:year)
      .uniq
      .sort
      .reverse
  end

helper_method :years

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