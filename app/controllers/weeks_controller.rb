class WeeksController < InheritedResources::Base
  before_filter :authenticate_user!
  
  def update
    update! { '/' }
  end
  
  def edit
    @week = Week.find(params[:id])
    unless current_user.is_admin? || @week.naming_rights == current_user
      flash[:error] = 'Only the winner of the previous week gets to name the next week'
      redirect_to '/'
    end
  end
  
  def show
    @week = Week.find_by(:season_id => Season.find_by(:year => params[:year]).id, :week_number => params[:week])
    
    # clear other unpublished posts except most recent
    unpublished = @week.comments.where(:user_id => current_user.id).where(:status => 'preview')
    if unpublished.size > 1
      unpublished[1..-1].each(&:destroy!)
    end
  end
  
    
  def permitted_params
    params.permit(:week => [:name, :closing_date, :currency_id, :comment => [:user_id, :week_id, :content, :image]] )
  end
  
end