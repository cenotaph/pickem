class CurrenciesController < ApplicationController
  before_filter :authenticate_user! , :except => [:index]
  
  def index
    @currencies = Currency.all
  end
  
  def new
    @currency = Currency.new
  end
  
  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      flash[:notice] = 'Currency saved'
      redirect_to currencies_path
    else
      flash[:error] = 'Error saving currency'
      render 'new'
    end
  end
  
  def edit
    @currency = Currency.find(params[:id])
  end
  
  def update
    @currency = Currency.find(params[:id])
    if @currency.update_attributes(currency_params)
      flash[:notice] = 'Currency saved'
      redirect_to currencies_path
    else
      flash[:error] = 'Error saving currency'
      render 'new'
    end
  end
  
  def destroy
    @currency = Currency.find(params[:id])
    @currency.destroy
    redirect_to currencies_path
  end
  
  private
  
  def currency_params
    params.require(:currency).permit(:name, :country, :iso4217, :wikipedia_link, :symbol)
  end
   
end