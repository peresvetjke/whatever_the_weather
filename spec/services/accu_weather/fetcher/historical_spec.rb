require 'rails_helper'

describe AccuWeather::Fetcher::Historical do
  subject do
    VCR.use_cassette('historical') do
      described_class.new.call
    end
  end

  it 'returns array with 24 elements' do
    is_expected.to be_instance_of Array
    expect(subject.size).to eq 24
  end

  it 'returns weathers' do
    expect(subject.sample).to include('LocalObservationDateTime', 'Temperature')
  end
end
