class AddPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean, null: false, default: false
    add_column :posts, :published_at, :date
  end
end
