class AddAuthorIdToBookReviews < ActiveRecord::Migration
  def change
    add_column :book_reviews, :author_id, :integer
  end
end
