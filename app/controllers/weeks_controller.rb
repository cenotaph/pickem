class WeeksController < ApplicationController
  before_filter :authenticate_user!
  
  
  def edit
    @week = Week.find(params[:id])
    unless current_user.is_admin? || @week.naming_rights == current_user
      flash[:error] = 'Only the winner of the previous week gets to name the next week'
      redirect_to '/'
    end
  end
  
  def score
    unless current_user.is_admin?
      flash[:error] = 'Only admins can do this'
      redirect_to '/'
    end
    @week = Week.find(params[:id])
    User.all.each {|x| @week.week_users << WeekUser.new(:user => x) if @week.week_users.where(:user => x).empty? }
  end
  
  def show
    @week = Week.find_by(:season_id => Season.find_by(:year => params[:year]).id, :week_number => params[:week])
    # clear other unpublished posts except most recent
    unpublished = @week.comments.where(:user_id => current_user.id).where(:status => 'preview')
    if unpublished.size > 1
      unpublished[1..-1].each(&:destroy!)
    end
  end
  
  def update  
    @week = Week.find(params[:id])
    if @week.update_attributes(params.permit(:week => [:name, :closing_date, :currency_id, week_users_attributes: [:id, :score]])[:week])
      if params[:week][:week_users_attributes]      
        unless current_user.is_admin?
          flash[:error] = 'Only admins can do this'
          redirect_to '/'
        end
        @week.do_exchange
        flash[:notice] = 'The week has been saved.'
      end
    end
    redirect_to '/'
  end
    
  def permitted_params
    params.permit(:week => [:name, :closing_date, :currency_id, week_users_attributes: [:id, :score]], 
        :comment => [:user_id, :week_id, :content, :image],
    )
  end
  
end