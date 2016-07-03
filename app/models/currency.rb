class Currency < ActiveRecord::Base

  validates_presence_of :name, :iso4217, :symbol, :wikipedia_link
  validates_uniqueness_of :iso4217
end
