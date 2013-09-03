if Rails.env.production?
  OpenExchangeRates.configure do |config|
    config.app_id = ENV['OPEN_EXCHANGE_KEY']
  end 
   
end

Money.default_currency = Money::Currency.new(Currency.find(Season.last.basecurrency_id).iso4217)
