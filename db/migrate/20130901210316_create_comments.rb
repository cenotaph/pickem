class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :week, index: true
      t.references :user, index: true
      t.string :image
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
