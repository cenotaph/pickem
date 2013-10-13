class AddFinalScoreToWeekUsers < ActiveRecord::Migration
  def change
    add_column :week_users, :final_score, :float
    WeekUser.all.each do |wu|
      wu.final_score = wu.money_adjusted * wu.week.exchange_rate
      wu.save
    end
  end
end
