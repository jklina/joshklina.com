class MakeTagsPolymorpic < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.references :taggable, polymorphic: true, index: true
    end
  end
end
