class SeasonsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :latest]
  before_filter :check_for_admin, except: [:latest]
  
  def index
    @seasons = Season.all
  end
  
  def create
    @season = Season.new(season_params)
    if @season.save
      flash[:notice] = 'Season defined'
      redirect_to '/'
    else
      flash[:error] = 'Error saving season'
      render 'new'
    end
  end
  
  def join
    @season = Season.friendly.find(params[:id])
    @season.users << current_user
    @season.save
    render 'show'
  end
  def latest
    @season = @current_season
    if current_user
      if @current_season.users.include?(current_user)
        render 'show'
      else
        render 'join_season'
      end
    else
      render 'show'
    end
  end
  
  def new
    @season = Season.new
  end
  
  def update
    @season = Season.find(params[:id])
    
  end
    
  def destroy
    @season = Season.friendly.find(params[:id])
    @season.destroy
    redirect_to '/'
  end
  
  private
  
  def season_params
    params.require(:season).permit(:year, :name, :basecurrency_id)
  end  
end
