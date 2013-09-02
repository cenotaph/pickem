class CreateWeekUsers < ActiveRecord::Migration
  def change
    create_table :week_users do |t|
      t.references :week, index: true
      t.integer :score
      t.references :user, index: true

      t.timestamps
    end
  end
end
