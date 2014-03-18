require 'spec_helper'
require 'redis'
require 'sidekiq'
require 'weather/weathergetter'

describe WundergroundWorker do

  include Sidekiq::Worker

  let(:ww) { WundergroundWorker.new }
  let(:site) { FactoryGirl.create(:site) }
  let(:zipcode) { 94612 }

  context 'when passed site' do
    it '#perform' do
      ww.should respond_to(:perform)
      data = ww.perform(site.id)
      data.each do |f|
        f['pop'].should be_between(0,100)
        f['qpf_allday'].count.should == 2
        f['qpf_allday']['in'].should be_between(0,100)
        f['date']['day'].should be_between(0,31)
      end
    end

    it '#perform_async' do
      data = WundergroundWorker.perform_async(site.id)
      data.class.should == String
    end
  end
end
