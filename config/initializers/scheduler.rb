require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

if Rails.env.production?
  scheduler.every '1s' do
    Rails.logger.info "Starting AccuWeather::Updater..."
    AccuWeather::Updater.new.call
    Rails.logger.info "Current weather successfully updated."
  end
end
