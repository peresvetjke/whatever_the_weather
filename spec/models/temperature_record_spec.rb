require 'rails_helper'

RSpec.describe TemperatureRecord, type: :model do
  let!(:temperature_records) do
    1.upto(24).to_a.map do |n|
      create(:temperature_record, date_time: n.hour.ago, temperature_celsius: 30 - n)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:temperature_celsius) }
    it { should validate_presence_of(:date_time) }
    it { should validate_uniqueness_of(:date_time) }
  end

  describe '.current' do
    subject do
      VCR.use_cassette('current') do
        described_class.current
      end
    end

    let(:service) { instance_double(AccuWeather::Fetcher::Current) }
    # it { expect(described_class.first.temperature_celsius).to eq 29 }
    it 'calls AccuWeather::Fetcher' do
      expect(AccuWeather::Fetcher::Current).to receive(:new).and_return(service)
      expect(service).to receive(:call)
      subject
    end

    it { expect(subject.temperature_celsius).to eq 21.1 }
  end

  describe '.last_24_hours' do
    subject { described_class.last_24_hours }

    it { expect(subject.ids).to match_array(temperature_records.map(&:id)) }
  end

  describe '.max_of_last_24_hours' do
    subject { described_class.max_of_last_24_hours }

    it { is_expected.to eq 29 }
  end

  describe '.min_of_last_24_hours' do
    subject { described_class.min_of_last_24_hours }

    it { is_expected.to eq 6 }
  end

  describe '.avg_of_last_24_hours' do
    subject { described_class.avg_of_last_24_hours }

    let(:result) { 1.upto(24).to_a.map { |n| 30 - n }.sum / 24.0 }

    it { is_expected.to eq result }
  end

  describe '.by_timestamp' do
    subject { described_class.by_timestamp(timestamp) }

    context 'with records' do
      let!(:suitable_record) { create(:temperature_record, date_time: DateTime.parse('2021-05-24 08:00'), temperature_celsius: 25) }
      let!(:unsuitable_records) do
        [
          create(:temperature_record, date_time: DateTime.parse('2021-05-24 09:00'), temperature_celsius: 30),
          create(:temperature_record, date_time: DateTime.parse('2021-05-24 07:00'), temperature_celsius: 20)
        ]
      end

      context 'record with equal timestamp' do
        let(:timestamp) { 1621843200 }

        it { expect(suitable_record.temperature_celsius).to eq 25 }
      end


      context 'timestamp between two records' do
        let(:timestamp) { DateTime.parse('2021-05-24 08:00').to_i  + 60 * 60 / 2 }

        it { expect(suitable_record.temperature_celsius).to eq 25 }
      end

      context 'record with close timestamp' do
        let(:timestamp) { DateTime.parse('2021-05-24 08:00').to_i  + 60 * 60 / 2 / 2 }

        it { expect(suitable_record.temperature_celsius).to eq 25 }
      end
    end
  end
end
