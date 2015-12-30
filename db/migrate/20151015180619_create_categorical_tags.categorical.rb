# This migration comes from categorical (originally 20150919153408)
class CreateCategoricalTags < ActiveRecord::Migration
  def change
    create_table :categorical_tags do |t|
      t.string :label

      t.timestamps null: false
    end
  end
end
