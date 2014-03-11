require 'spec_helper'
require 'redis'
require 'sidekiq'
require 'weather/weathergetter'

describe WeatherWorker do

  include Sidekiq::Worker

  let(:ww) { WeatherWorker.new }
  let(:zipcode) { 94612 }

  context 'when passed zipcode' do
    it '#perform' do
      ww.should respond_to(:perform)
      data = ww.perform(zipcode)
      pp data
    end

    it 'gets forecast using worker' do
      data = WeatherWorker.perform_async(zipcode)
      pp data
    end
  end
end
