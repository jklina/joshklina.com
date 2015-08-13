class AddIndexToTag < ActiveRecord::Migration
  def change
    add_index :tags, :slug, unique: true
  end
end
