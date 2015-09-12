class MakeTagsPolymorphic < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :taggable, polymorphic: true, index: true
      t.integer :tag_id
    end
    change_table :tags do |t|
      t.remove_index column: [:taggable_type, :taggable_id]
      t.remove :taggable_id, :taggable_type
    end
  end
end
