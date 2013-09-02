class Comment < ActiveRecord::Base
  belongs_to :week
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images, :reject_if => proc {|x| x['filename'].blank? }
  validates_presence_of :week_id, :user_id, :content
  
  scope :published, -> { where(status: 'published')}
  
end
