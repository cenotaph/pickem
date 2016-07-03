class Season < ActiveRecord::Base
  has_many :weeks
  has_many :users, through: :seasons_users
  has_many :seasons_users
  belongs_to :basecurrency, :class_name => 'Currency'
  validates_presence_of :year
  after_create :create_weeks
  
  extend FriendlyId
  friendly_id :year, use: :slugged 
  
  def create_weeks
    (0..21).each do |w|
      self.weeks << Week.new(week_number: w)
    end
  end
end
