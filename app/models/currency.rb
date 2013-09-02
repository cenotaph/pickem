class Currency < ActiveRecord::Base

  validates_presence_of :name, :iso4217, :symbol, :wikipedia_link
end
