require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

unless Rails.env.test?
  scheduler.every '10m' do
    AccuWeather::Updater.new.call
  end
end
