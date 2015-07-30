class AddIndexToTags < ActiveRecord::Migration
  def change
    add_index :tags, :label, unique: true
  end
end
