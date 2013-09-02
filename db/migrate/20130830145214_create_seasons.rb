class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year
      t.string :name

      t.timestamps
    end
    execute("INSERT INTO seasons (year, name) VALUES (2013, 'All hail the Canadian Dollar!');")
  end
end
