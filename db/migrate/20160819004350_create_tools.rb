class CreateTools < ActiveRecord::Migration[5.0]
  def change
    create_table :tools do |t|
      t.string :title
      t.string :url
      t.string :body
      t.string :slug
      t.string :slug
      t.integer :author_id

      t.timestamps
    end
  end
end
