class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  mount_uploader :avatar, AvatarUploader
  has_many :weeks, :through => :week_users
  has_many :week_users
  
  extend FriendlyId
  friendly_id :name, use: :slugged 
  
  def current_score
    week_users.map(&:money_adjusted_converted).sum
  end
  
  def display_name
    yahoo_name || name
  end
  
  def is_admin?
    is_admin
  end
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info

      user = User.where(:email => data["email"]).first
      
      if !user  && APPROVED_USERS.include?(data["email"])
          user = User.create(name: data["name"],
  	    		   email: data["email"],
               is_admin: APPROVED_ADMINS.include?(data["email"]) ? true : false
  	    		  )
      end
      user
  end
  
end
