class ConversionController < ApplicationController
    @@currencies = { "USD" => "United States dollar",
      "JPY" => "Japanese yen",
      "BGN" => "Bulgarian lev",
      "CZK" => "Czech koruna",
      "DKK" => "Danish krone",
      "GBP" => "Pound Sterling",
      "HUF" => "Hungarian forint",
      "PLN" => "Polish złoty",
      "RON" => "Romanian leu",
      "SEK" => "Swedish krona",
      "CHF" => "Swiss franc",
      "NOK" => "Norwegian krone",
      "HRK" => "Croatian kuna",
      "RUB" => "Russian ruble",
      "TRY" => "Turkish lira",
      "AUD" => "Australian dollar",
      "BRL" => "Brazilian real",
      "CAD" => "Canadian dollar",
      "CNY" => "Chinese yuan",
      "HKD" => "Hong Kong dollar",
      "IDR" => "Indonesian rupiah",
      "ILS" => "Israeli new shekel",
      "INR" => "Indian rupee",
      "KRW" => "South Korean won",
      "MXN" => "Mexican peso",
      "MYR" => "Malaysian ringgit",
      "NZD" => "New Zealand dollar",
      "PHP" => "Philippine peso",
      "SGD" => "Singapore dollar",
      "THB" => "Thai baht",
      "ZAR" => "South African rand",
      "EUR" => "Euro" 
    }

  def index
    @currencies = @@currencies
    @conversion = Conversion.new
  end

  def convert
    @currencies = @@currencies

    @conversion = Conversion.new(      
      Date.parse(params["conversion"]["date"]),
      params["conversion"]["amount"],
      params["conversion"]["from"],
      params["conversion"]["to"])
    
    rate = ExchangeRate.at(@conversion.date, @conversion.from, @conversion.to)
    @rate = rate.round(4)
    @converted_amount = (@conversion.amount.to_f * @rate).round(2)
    render "index"
  end
end