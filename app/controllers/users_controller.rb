class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :edit, :update, :index
  
  def edit
    @user = User.friendly.find(params[:id])
    if @user != current_user
      unless current_user.is_admin?
        flash[:error] = "This isn't you."
        redirect_to '/'
      end
    end
  end
  
  
  def update
    @user = User.friendly.find(params[:id])
    
    update! { '/' }
  end


  
  def permitted_params
    params.permit(:user => [:avatar, :slug, :yahoo_name])
  end
end
