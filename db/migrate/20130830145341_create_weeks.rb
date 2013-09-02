class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.references :season, index: true
      t.string :name
      t.date :closing_date
      t.integer :week_number

      t.timestamps
    end
    (0..21).each do |w|
      execute("INSERT INTO weeks (week_number, season_id) values (#{w}, 1);")
    end
  end
end
