class Week < ActiveRecord::Base
  belongs_to :season
  belongs_to :currency
  has_many :comments
end
