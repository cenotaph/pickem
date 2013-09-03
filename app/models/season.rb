class Season < ActiveRecord::Base
  has_many :weeks
  belongs_to :basecurrency, :class_name => 'Currency'
end
