require 'nokogiri'
require 'open-uri'
require 'date'
require 'bigdecimal'

class ExchangeRate < ApplicationRecord
    ECB_URL = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'

    # Import exchange rates from the ECB feed to local DB
    def ExchangeRate.import
        doc = Nokogiri::HTML(open(ECB_URL))
        days = doc.xpath("//*[@time]")
        temp = {}
        days.each do |day|
            time = Date.parse(day.xpath("@time").to_s)
            currencies = day.xpath(".//*[@rate]")
            currencies.each do |currency|
                currency_name = currency.xpath("@currency").to_s
                rate = BigDecimal.new(currency.xpath("@rate").to_s)

                dbrate = ExchangeRate.find_by_date_and_currency(time, currency_name)
                if dbrate.nil? then
                    puts "Inserting #{time}, #{currency}, #{rate}"
                    exchange_rate = ExchangeRate.new
                    exchange_rate.date = time
                    exchange_rate.currency = currency_name
                    exchange_rate.rate = rate
                    exchange_rate.save
                else
                    puts "Skipping #{time}, #{currency_name}, #{rate}"
                end
            end
        end
    end #ExchangeRate.import

    # Get exchange rate for given date
    def ExchangeRate.at(date, from, to)
        # Handle Euros - they're not in the DB as rates are all Euro based
        if(from == "EUR") then
            from_currency = ExchangeRate.new {|e| e.date = date, e.currency = "EUR", e.rate = 1}
        else
            from_currency = ExchangeRate.find_by_date_and_currency(date, from)
        end
        if(to == "EUR") then
            to_currency = ExchangeRate.new {|e| e.date = date, e.currency = "EUR", e.rate = 1}
        else
            to_currency = ExchangeRate.find_by_date_and_currency(date, to)
        end
        raise "From currency doesn't exist" if from_currency.nil? 
        raise "To currency doesn't exist" if to_currency.nil?

        # All rates are Euro based so from -> EUR (divide by from rate) then EUR -> to (multiply by to rate)
        rate = 1 / from_currency.rate * to_currency.rate
        return rate
    end #ExchangeRate.at
end
