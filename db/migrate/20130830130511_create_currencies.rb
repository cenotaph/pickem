class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :iso4217, :length => 3
      t.string :country
      t.string :wikipedia_link
      t.string :symbol

      t.timestamps
    end
  end
end
