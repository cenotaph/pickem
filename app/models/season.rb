class Season < ActiveRecord::Base
  has_many :weeks
  has_many :users
  belongs_to :basecurrency, :class_name => 'Currency'
  validates_presence_of :year
  
  extend FriendlyId
  friendly_id :year, use: :slugged 
end
