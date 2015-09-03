class AddPublishedToBookReview < ActiveRecord::Migration
  def change
    add_column :book_reviews, :published, :boolean, null: false, default: false
  end
end
