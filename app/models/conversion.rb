require 'date'

class Conversion
    attr_accessor :date, :amount, :from, :to
    attr_reader :min_date, :max_date

    def initialize(date = nil, amount = 1, from = "GBP", to = "GBP")
        @min_date = ExchangeRate.minimum(:date)
        @max_date = ExchangeRate.maximum(:date)
        
        @date = @date || @max_date
        @amount = amount
        @from = from
        @to = to
    end
end