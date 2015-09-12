class RenameBookAttributes < ActiveRecord::Migration
  def change
    change_table :book_reviews do |t|
      t.rename :title, :book_title
      t.rename :author, :book_author
      t.rename :review, :body
    end
  end
end
