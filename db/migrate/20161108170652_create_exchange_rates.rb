class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.date :date
      t.string :currency
      t.decimal :rate, precision: 10, scale: 5
      t.timestamps
    end
  end
end
