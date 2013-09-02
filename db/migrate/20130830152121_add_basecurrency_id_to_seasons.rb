class AddBasecurrencyIdToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :basecurrency_id, :integer
  end
end
