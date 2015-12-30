# This migration comes from categorical (originally 20151011215525)
class CreateCategoricalTaggings < ActiveRecord::Migration
  def change
    create_table :categorical_taggings do |t|
      t.references :taggable, polymorphic: true, index: true
      t.integer :tag_id
    end
  end
end
