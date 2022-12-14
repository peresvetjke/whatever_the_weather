class TemperatureRecord < ApplicationRecord
  SECONDS_IN_HOUR = 3600
  UNIT_OF_MEASURE = '°C'

  validates :temperature_celsius, :date_time, presence: true
  validates :date_time, uniqueness: true

  default_scope { order(date_time: :desc) }

  class << self
    def current
      Rails.cache.fetch("current", expires_in: 10.minutes) do
        AccuWeather::Fetcher::Current.new.call
      end
    end

    def last_24_hours
      Rails.cache.fetch("last_24_hours", expires_in: 10.minutes) do
        order(date_time: :desc).limit(24)
      end
    end

    def max_of_last_24_hours
      last_24_hours.pluck(:temperature_celsius).max
    end

    def min_of_last_24_hours
      last_24_hours.pluck(:temperature_celsius).min
    end

    def avg_of_last_24_hours
      values = last_24_hours.pluck(:temperature_celsius)
      return if values.empty?

      values.sum.to_f / values.size
    end

    def by_timestamp(timestamp)
      where('date_time >= ?', Time.zone.at(timestamp - SECONDS_IN_HOUR / 2))
        .where('date_time <= ?', Time.zone.at(timestamp + SECONDS_IN_HOUR / 2))
        .order(date_time: :asc).first
    end
  end

  def date_time=(dt)
    super(dt&.beginning_of_hour)
  end
end
