class CurrenciesController < InheritedResources::Base
  before_filter :authenticate_user! , :except => [:index]
  
  def create
    create! { currencies_path }
  end
  
  def update
    update! { currencies_path }
  end
  
  def destroy
    destroy! { currencies_path } 
  end
  

  def permitted_params
    params.permit(:currency => [:name, :country, :iso4217, :wikipedia_link, :symbol])
  end
   
end