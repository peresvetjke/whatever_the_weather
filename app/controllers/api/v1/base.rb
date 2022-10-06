# So, let's build the base class for version one of our API.

# This class has one responsibility––mount another class that will access our Graduate model.
module Api
  module V1
    class Base < Grape::API
      format :json
      namespace 'weather' do
        desc 'Current temperature'
        get 'current' do

        end

        desc 'Historical temperature for last 24 hours'
        get 'historical' do
          
        end

        desc 'Max temperature for last 24 hours'
        get 'max' do
          
        end

        desc 'Min temperature for last 24 hours'
        get 'min' do
          
        end

        desc 'Average temperature for last 24 hours'
        get 'avg' do
          
        end

        desc 'Temperature by timestamp'
        get 'by_time/:timestamp' do
          params do
            requires :timestamp, type: Integer, desc: 'Timestamp'
          end
        end
      end

      desc 'Backend status'
      get 'health' do
        
      end
      # mount Api::V1::Graduates
      # mount API::V1::AnotherResource
    end
  end
end
