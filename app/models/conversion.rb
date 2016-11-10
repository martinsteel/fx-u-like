require 'date'

class Conversion
    attr_accessor :date, :amount, :from, :to
    attr_reader :min_date, :max_date

    def initialize(date = Date.today, amount = 0, from = "GBP", to = "GBP")
        @date = date
        @amount = amount
        @from = from
        @to = to
        @min_date = ExchangeRate.minimum(:date)
        @max_date = ExchangeRate.maximum(:date)
    end
end