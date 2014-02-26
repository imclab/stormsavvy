require 'spec_helper'
require 'rake'

Stormsavvy::Application.load_tasks
# load File.join(Rails.root, 'lib', 'tasks', 'scheduler.rake')

describe 'scheduler' do
  self.use_transactional_fixtures = false

  let!(:user) {
    FactoryGirl.build(
      :user,
      firstname: 'yoda',
      lastname: 'jedi',
      email: 'yoda@starwars.com'
    )
  }
  let!(:site) {
    FactoryGirl.create(
      :site,
      user: user
    )
  }

  context 'when running tasks' do
    # setup do
    #   @out = `cd #{Rails.root} && rake scheduler:northbay_forecast`
    # end

    describe '#northbay_forecast' do
      it 'sends northbay_forecast' do
        Rake::Task['scheduler:northbay_forecast'].invoke
      end
    end

    describe '#pop_alert' do
      it 'sends pop_alert' do
        Rake::Task['scheduler:pop_alert'].invoke
      end
    end

    describe '#check_pop_alert' do
      it 'checks for pop_alert' do
        Rake::Task['scheduler:check_pop_alert'].invoke
      end
    end

    describe '#daily_mailer' do
      it 'sends daily_mailer' do
        Rake::Task['scheduler:daily_mailer'].invoke
      end
    end

    describe '#pester_admins' do
      xit 'sends pester_admins' do
        Rake::Task['scheduler:pester_admins'].invoke
      end
    end

    describe '#staging_mailer' do
      xit 'sends staging_mailer' do
        Rake::Task['scheduler:staging_mailer'].invoke
      end
    end

    describe '#mailout' do
      it 'sends mailout' do
        Rake::Task['scheduler:mailout'].invoke
      end
    end

    describe '#thankyou' do
      it 'sends thankyou' do
        Rake::Task['scheduler:thankyou'].invoke
      end
    end

    describe '#noaa_forecast' do
      xit 'sends noaa_forecast' do
        Rake::Task['scheduler:noaa_forecast'].invoke
      end
    end

    describe '#wg_forecast' do
      xit 'sends wg_forecast' do
        Rake::Task['scheduler:wg_forecast'].invoke
      end
    end
  end
end
