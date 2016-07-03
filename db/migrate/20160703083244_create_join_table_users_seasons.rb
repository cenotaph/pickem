class CreateJoinTableUsersSeasons < ActiveRecord::Migration[5.0]
  def self.up
    create_table :seasons_users do |t|
      t.references :user
      t.references :season
      t.float :final_luck
    end
    add_index :seasons_users, [:user_id, :season_id]
    
   
  end
  
  def data
    
    # put final luck in place
    User.all.each do |user|
      user.seasons << Season.first
      su = user.seasons_users.first
      su.final_luck = user.week_users.map(&:luck_index).sum
      su.save!
    end
  end
  
  def self.down
    drop_table :seasons_users
  end

end
