class AddSlugToCategoricalTags < ActiveRecord::Migration
  def change
    add_column :categorical_tags, :slug, :string
    add_index :categorical_tags, :slug, unique: true
  end
end
