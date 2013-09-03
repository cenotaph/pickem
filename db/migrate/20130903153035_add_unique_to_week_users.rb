class AddUniqueToWeekUsers < ActiveRecord::Migration
  def change
    add_index :week_users, [:week_id, :user_id]
  end
end
