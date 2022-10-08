require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

if Rails.env.production?
  scheduler.every '10m' do
    Rails.logger.info "Starting AccuWeather::Updater..."
    AccuWeather::Updater.new.call
    Rails.logger.info "Current weather successfully updated."
  rescue => e
    Rails.logger.error "Error occured :("
    Rails.logger.info e
  end
end
