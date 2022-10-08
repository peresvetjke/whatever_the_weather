require 'rails_helper'

describe AccuWeather::Updater do
  subject do
    VCR.use_cassette('current') do
      described_class.new.call
    end
  end

  before do
    travel_to Time.zone.parse('2022-10-06T22:30:00+04:00')
    temperature_record
  end

  after do
    travel_back
  end

  context 'without record in db' do
    let(:temperature_record) { nil }

    it 'creates new temperature_records' do
      expect { subject }.to change(TemperatureRecord, :count).by(1)
    end
  end

  context 'with record in db' do
    let(:temperature_record) { create(:temperature_record, date_time: Time.zone.parse('2022-10-06T22:00:00+04:00'), temperature_celsius: 20) }

    it 'does not create any temperature_record' do
      expect { subject }.not_to change(TemperatureRecord, :count)
    end

    it 'updates temperature_record' do
      subject
      expect(temperature_record.reload.temperature_celsius).to eq 21.1
    end
  end
end
