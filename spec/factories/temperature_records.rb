FactoryBot.define do
  factory :temperature_record do
    temperature_celsius { 1.5 }
    local_observation_date_time { "2022-10-05 22:40:29" }
  end
end
