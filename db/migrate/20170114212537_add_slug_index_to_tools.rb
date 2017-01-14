class AddSlugIndexToTools < ActiveRecord::Migration[5.0]
  def change
    add_index :tools, :slug, unique: true
  end
end
