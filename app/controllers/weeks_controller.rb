class WeeksController < InheritedResources::Base
  before_filter :authenticate_user!
  
  def show
    @week = Week.find_by(:season_id => Season.find_by(:year => params[:year]).id, :week_number => params[:week])
    
    # clear other unpublished posts except most recent
    unpublished = @week.comments.where(:user_id => current_user.id).where(:status => 'preview')
    if unpublished.size > 1
      unpublished[1..-1].each(&:destroy!)
    end
  end
  
  private
    
  def week_params 
    params.permit(:week).permit([:name, :closing_date, :currency_id, :comment => [:user_id, :week_id, :content, :image] ])
  end
  
end