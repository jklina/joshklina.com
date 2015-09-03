class BookReviewsController < ApplicationController
  def index
    @book_reviews = BookReview.sorted_by_published_date.
      page(params[:page]).
      per(10)
  end
end
