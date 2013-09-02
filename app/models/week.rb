class Week < ActiveRecord::Base
  belongs_to :season
  belongs_to :currency
  has_many :comments
  has_many :week_users
  
  def winner
    week_users.empty? ? nil : week_users.sort(&:score).last.user
  end
  
  def naming_rights
    if week_number == 1
      # hardcoding that john gets to name week 1 since he won last year
      User.find(1)
    else
      Week.find_by(:week_number => week_number - 1 ).winner
    end
  end
  
  
  def score?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.where(:user => user).score
  end
  
  def tentative_name
    if name.blank?
      if naming_rights.nil? 
        'winner of week ' + (week_number - 1).to_s + ' will choose'
      else
        naming_rights.name + ' has naming rights'
      end
    else
      name
    end
  end
end
