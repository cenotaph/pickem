class WeekUser < ActiveRecord::Base
  belongs_to :week
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :week_id
  
  
  def money_adjusted_converted
    money_adjusted * week.exchange_rate
  end
  
  def money_adjusted
    pot_earnings - money_owed
  end
  
  def money_owed
    points  * week.exchange_rate * -1
  end
  
  def pot_earnings
    return 0 if score.nil?
    (score.to_f / WeekUser.where(:week => week).map(&:score).sum.to_f) * week.total_pot
  end
  
  def points
    return 0 if score.nil?
    # find winner within own structure
    all_week_scores = WeekUser.where(:week => week).sort_by(&:score)
    winner = all_week_scores.last
    if winner == self
      # you won
      0
    else
      # you owe, so figure out the person who scored above you
      score - all_week_scores.last.score 
    end
  end  
  
  def distance_from_next
    # find winner within own structure
    all_week_scores = WeekUser.where(:week => week).sort_by(&:score)
    winner = all_week_scores.last
    if winner == self
      # you won
      "winner"
    else
      # you owe, so figure out the person who scored above you
      all_week_scores.each_with_index do |wu, index|
        if wu == self
          return score - all_week_scores[index+1].score
        end
      end
    end
  end
end
