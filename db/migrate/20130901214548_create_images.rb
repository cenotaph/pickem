class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :content_type
      t.integer :size, :limit => 8
      t.integer :height
      t.integer :width
      t.references :comment, index: true

      t.timestamps
    end
  end
end
