require 'rails_helper'

describe AccuWeather::Fetcher::Current do
  subject do
    VCR.use_cassette('current') do
      described_class.new.call
    end
  end

  it 'returns array with single element' do
    is_expected.to be_instance_of Array
    expect(subject.size).to eq 1
  end

  it 'returns weather' do
    expect(subject.first).to include('LocalObservationDateTime', 'Temperature')
  end
end
