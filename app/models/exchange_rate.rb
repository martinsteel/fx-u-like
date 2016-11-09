require 'nokogiri'
require 'open-uri'
require 'date'
require 'bigdecimal'

class ExchangeRate < ApplicationRecord
    ECB_URL = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'

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
end
