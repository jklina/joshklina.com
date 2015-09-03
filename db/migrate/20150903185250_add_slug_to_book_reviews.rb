class AddSlugToBookReviews < ActiveRecord::Migration
  def change
    add_column :book_reviews, :slug, :string
  end
end
