class Week < ActiveRecord::Base
  belongs_to :season
  belongs_to :currency
  has_many :comments
  has_many :week_users
  accepts_nested_attributes_for :week_users
  
  def winner
    week_users.empty? ? nil : week_users.sort_by(&:score).last.user
  end
  
  def winner_name
    winner.nil? ? '' : winner.display_name
  end
  
  def naming_rights
    if week_number == 1
      # hardcoding that john gets to name week 1 since he won last year
      User.find(1)
    else
      Week.find_by(:week_number => week_number - 1 ).winner
    end
  end
  
  def open?
    closing_date.nil?
  end
  
  def score?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.find_by(:user => user).score
  end
  
  def points?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.find_by(:user => user).points
  end
      
  def pot_earnings?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.find_by(:user => user).pot_earnings 
  end
  
  def money_adjusted?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.find_by(:user => user).money_adjusted
  end
  
  def money_owed?(user)
    week_users.where(:user => user).empty? ? 0 : week_users.find_by(:user => user).money_owed
  end
  
  def total_pot
    week_users.map(&:money_owed).sum 
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
  
  def do_exchange
  
    # pick random currency
    c = Currency.new
    loop do
      c = Currency.random
      break if Week.where(:currency => c).empty? && Money.default_currency.iso_code != c.iso4217
    end
    fx = OpenExchangeRates::Rates.new
    self.exchange_rate = fx.exchange_rate(:from => c.iso4217, :to => Money.default_currency.iso_code)
    self.currency = c
    self.closing_date = Date.today
    self.save!
  end
    
end
