class AddPublishedAtToBookReviews < ActiveRecord::Migration
  def change
    add_column :book_reviews, :published_at, :date
  end
end
