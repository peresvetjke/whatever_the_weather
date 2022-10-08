require 'rails_helper'

describe AccuWeather::Fetcher::Current do
  subject do
    VCR.use_cassette('current') do
      described_class.new.call
    end
  end

  it 'returns TemperatureRecord' do
    is_expected.to be_instance_of TemperatureRecord
  end

  it 'returns weather' do
    expect(subject.temperature_celsius).to eq 21.1
  end
end
