class FxController < ApplicationController
  def index
  end

  def test
    

    @exchange_rates = ExchangeRate.all
  end
end
