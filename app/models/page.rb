class Page < ActiveRecord::Base
  validates_presence_of :name, :body
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
end
