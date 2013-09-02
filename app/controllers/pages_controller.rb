class PagesController < InheritedResources::Base
  
  before_filter :authenticate_user!
  before_filter :check_for_admin, :except => [:index, :show]
    
  def edit
    @page = Page.friendly.find(params[:id])
  end
  
  def create
    create! { pages_path }
  end
  
  def update
    @page = Page.friendly.find(params[:id])
    update! { pages_path }
  end
  
  def destroy
    @page = Page.friendly.find(params[:id])
    destroy! { pages_path } 
  end
  
  protected

  def permitted_params
    params.permit(:page => [:name, :body, :slug])
  end
end
