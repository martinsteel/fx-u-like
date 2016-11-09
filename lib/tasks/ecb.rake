namespace :ecb do
    desc "Update exchange rates from ECB feed"
    task :update_rates => :environment do
        ExchangeRate.import
    end
end
