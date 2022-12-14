require "rails_helper"

describe "Weather API", type: :request do
  let(:method) { "get" }
  let(:existing_records) { [] }
  let(:last_24_records) do
    1.upto(24).to_a.map do |n|
      create(:temperature_record, date_time: n.hour.ago, temperature_celsius: 30 - n)
    end
  end

  before do
    VCR.use_cassette('current') do
      existing_records
      do_request("get", path, params: { }, headers: headers)
    end
  end

  describe 'GET /api/v1/weather/current' do
    let(:path) { '/api/v1/weather/current' }

    let(:result) do
      {
        'date_time' => DateTime.parse("2022-10-06T22:00:00+04:00").iso8601,
        'value' => 21.1,
        'unit' => '°C'
      }
    end

    it { expect(response).to have_http_status 200 }

    it { expect(json).to eq result }
  end

  describe 'GET /api/v1/weather/historical' do
    let(:path) { '/api/v1/weather/historical' }

    context 'no records' do
      it { expect(response).to have_http_status 404 }
    end

    context 'with records' do
      let(:existing_records) { last_24_records }

      it 'returns array of 24 elements' do
        expect(json).to be_instance_of Array
        expect(json.size).to eq 24
      end

      it 'returns weather' do
        expect(json.sample).to include('value', 'unit', 'date_time')
      end
    end
  end

  describe 'GET /api/v1/weather/max' do
    let(:path) { '/api/v1/weather/max' }

    context 'no records' do
      it { expect(response).to have_http_status 404 }
    end

    context 'with records' do
      let(:existing_records) { last_24_records }

      it { expect(json).to eq 29 }
    end
  end

  describe 'GET /api/v1/weather/min' do
    let(:path) { '/api/v1/weather/min' }

    context 'no records' do
      it { expect(response).to have_http_status 404 }
    end

    context 'with records' do
      let(:existing_records) { last_24_records }

      it { expect(json).to eq 6 }
    end
  end

  describe 'GET /api/v1/weather/avg' do
    let(:path) { '/api/v1/weather/avg' }

    context 'no records' do
      it { expect(response).to have_http_status 404 }
    end

    context 'with records' do
      let(:existing_records) { last_24_records }

      let(:result) { 1.upto(24).to_a.map { |n| 30 - n }.sum / 24.0 }

      it { expect(json).to eq result }
    end
  end

  describe 'GET /api/v1/weather/by_time/:timestamp' do
    let(:path) { "/api/v1/weather/by_time/#{timestamp}" }
    let(:timestamp) { '1621843200' }

    context 'invalid params' do
      let(:timestamp) { 'wrong' }

      it { expect(response).to have_http_status 400 }
    end

    context 'no records' do
      it { expect(response).to have_http_status 404 }
    end

    context 'with records' do
      let(:existing_records) { [suitable_record, unsuitable_records] }
      let!(:suitable_record) { create(:temperature_record, date_time: DateTime.parse('2021-05-24 08:00'), temperature_celsius: 25) }
      let!(:unsuitable_records) do
        [
          create(:temperature_record, date_time: DateTime.parse('2021-05-24 09:00'), temperature_celsius: 30),
          create(:temperature_record, date_time: DateTime.parse('2021-05-24 07:00'), temperature_celsius: 20)
        ]
      end

      it { expect(response).to have_http_status 200 }
      it { expect(json['value']).to eq 25 }
    end
  end

  describe 'GET /api/v1/health' do
    let(:path) { '/api/v1/health' }

    it { expect(response).to have_http_status 200 }
    it { expect(json).to eq 'OK' }
  end
end
