class AddPublishableAttributesToTools < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :published_at, :date
    add_column :tools, :published, :boolean, null: false, default: false
  end
end
