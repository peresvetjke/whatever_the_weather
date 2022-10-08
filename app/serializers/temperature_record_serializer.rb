class TemperatureRecordSerializer < ActiveModel::Serializer
  attributes :value, :unit, :date_time

  def value
    object.temperature_celsius
  end

  def unit
    object.class::UNIT_OF_MEASURE
  end

  def date_time
    object.date_time.iso8601  
  end
end
