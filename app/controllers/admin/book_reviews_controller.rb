class Admin::BookReviewsController < Admin::AdminController
  def index
    @book_reviews = BookReview.sorted_by_published_date.
      page(params[:page]).
      per(25)
  end

  def new
    @book_review = BookReview.new
    find_authors
    find_tags
  end

  def create
    @book_review = BookReview.new(book_review_params)
    if @book_review.save
      flash[:success] = "Review successfully created."
      redirect_to admin_book_reviews_path

    else
      find_authors
      find_tags
      render :new
    end
  end

  def edit
    find_book_review
    find_authors
    find_tags
  end

  def update
    find_book_review
    find_authors
    find_tags
    if @book_review.update(book_review_params)
      flash[:success] = "Book review was successfully updated."
      redirect_to admin_book_reviews_path
    else
      render action: 'edit'
    end
  end

  private

  def find_book_review
    @book_review = BookReview.find_by_slug!(params[:id])
  end

  def find_authors
    @authors = User.all
  end

  def find_tags
    @tags = Categorical::Tag.all
  end

  def book_review_params
    params.require(:book_review).permit(:id, :book_title, :body, :slug, :published, :book_author, :image_url, :url, :author_id, tag_ids: [])
  end
end
