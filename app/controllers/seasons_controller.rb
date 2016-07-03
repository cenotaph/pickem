class SeasonsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_for_admin
  
  def index
    @seasons = Season.all
  end
  
  def update
    @season = Season.find(params[:id])
    
  end
    
  private
  
  def season_params
    params.require(:season).permit(:year, :name, :basecurrency_id)
  end  
end
