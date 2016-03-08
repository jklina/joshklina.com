class ConvertTablesToExposition < ActiveRecord::Migration
  def change
    rename_table :posts, :exposition_posts
    rename_table :users, :exposition_users

    add_column :exposition_posts, :summary, :text
  end
end
