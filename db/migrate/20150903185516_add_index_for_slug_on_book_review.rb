class AddIndexForSlugOnBookReview < ActiveRecord::Migration
  def change
    add_index :book_reviews, :slug, unique: true
  end
end
