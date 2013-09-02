class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :slug, :string
  end
end
