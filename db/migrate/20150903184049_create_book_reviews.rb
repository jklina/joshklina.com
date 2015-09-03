class CreateBookReviews < ActiveRecord::Migration
  def change
    create_table :book_reviews do |t|
      t.string :title
      t.string :url
      t.string :image_url
      t.text :review

      t.timestamps null: false
    end
  end
end
