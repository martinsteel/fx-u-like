require 'date'

class Conversion
    attr_accessor :date, :amount, :from, :to

    def initialize(date = Date.today, amount = 0, from = "GBP", to = "GBP")
        @date = date
        @amount = amount
        @from = from
        @to = to
    end
end