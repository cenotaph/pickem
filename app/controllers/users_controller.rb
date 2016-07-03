class UsersController < ApplicationController
  before_filter :authenticate_user!
  #actions :edit, :update, :index, :show
  
  def edit
    @user = User.friendly.find(params[:id])
    if @user != current_user
      unless current_user.is_admin?
        flash[:error] = "This isn't you."
        redirect_to '/'
      end
    end
  end
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.friendly.find(params[:id])
    
    update! { '/' }
  end

  def show
    @user = User.friendly.find(params[:id])
  end
  
  def omniauth_failure
    
     redirect_to '/'
     #redirect wherever you want.
   end

  private
  
  def permitted_params
    params.permit(:user => [:avatar, :slug, :yahoo_name])
  end
end
