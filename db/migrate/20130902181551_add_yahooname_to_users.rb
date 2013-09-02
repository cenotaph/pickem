class AddYahoonameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yahoo_name, :string
  end
end
