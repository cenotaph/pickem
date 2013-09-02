class AddCurrencyIdToWeeks < ActiveRecord::Migration
  def change
    add_reference :weeks, :currency, index: true
  end
end
