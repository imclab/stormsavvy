require 'spec_helper'
require 'typhoeus'
require 'json'
require 'weather/climategetter'

include Typhoeus

describe ClimateGetter do

  let(:site) { FactoryGirl.build(:site) }
  let(:ucb) { FactoryGirl.build(:site, name: 'ucb') }
  let(:ecp) { FactoryGirl.build(:site, name: 'ecp') }
  let(:sites) { [ site, ucb, ecp ] }
  let(:zipcode) { site.zipcode }

  let!(:cg) { ClimateGetter.new }
  let(:url) { "http://www.ncdc.noaa.gov/cdo-web/api/v2/datasets" }

  describe '#make_request' do
    it 'makes request' do
      cg.class.should == ClimateGetter
      cg.should respond_to(:make_request)
    end
  end

  describe '#make_request_with_cache' do
    it 'makes request with cache' do
      cg.should respond_to(:make_request_with_cache)
    end
  end

  describe '#get_station' do
    it 'reads json and does not query' do
      station = cg.get_station(site)
      pp station
    end
  end
end
