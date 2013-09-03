class AddExchangerateToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :exchange_rate, :float
  end
end
