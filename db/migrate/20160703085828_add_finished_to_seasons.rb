class AddFinishedToSeasons < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :finished, :boolean, default: false, null: false

  end

  def data
    execute('update seasons set finished = true, slug = year')
  end 
  
end
