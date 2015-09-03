class AddAuthorToBookReviews < ActiveRecord::Migration
  def change
    add_column :book_reviews, :author, :string
  end
end
