class WeekUser < ActiveRecord::Base
  belongs_to :week
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :week_id
  
  before_save :set_to_zero
  
  def set_to_zero
    if score.nil?
      score = 0
    end
  end
  
  def luck_index
    if score.nil? or week.exchange_rate.blank?
      return 0 
    else
      step = (20.to_f / (WeekUser.where("final_score is not null").count - 1).to_f )
  
      luck_index = -10 + (step * WeekUser.includes(:week).all.sort_by{|x| (-1 * (1 - x.week.exchange_rate.to_f)) * x.final_score.to_i}.index(self))
    end
    # if final_score >=0 
    #   week.exchange_rate > 1 ? luck_index : (-1 * luck_index)
    # else
    #   week.exchange_rate > 1 ? (-1 * luck_index) : luck_index
    # end
  end
  
  def money_adjusted_converted
    money_adjusted * week.exchange_rate.to_f
  end
  
  def money_adjusted
    pot_earnings - money_owed
  end
  
  def money_owed
    points  * week.exchange_rate.to_f * -1
  end
  
  def pot_earnings
    return 0 if score.nil?
    (score.to_f / WeekUser.includes(:week).where(:week => week).map{|x| x.score.to_i }.sum.to_f) * week.total_pot
  end
  
  def points
    return 0 if score.nil?
    # find winner within own structure
    all_week_scores = WeekUser.includes(:week).where(:week => week).sort_by{|x| x.score.to_i }
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
    all_week_scores = WeekUser.where(:week => week).sort_by{|x| x.score.to_i }
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
  
  def rank
    all_week_scores = WeekUser.where(:week => week).sort_by{|x| x.score.to_i }
    all_week_scores.index(self) + 1
  end  
end
