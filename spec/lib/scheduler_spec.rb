require 'spec_helper'
require 'rake'

Stormsavvy::Application.load_tasks
# load File.join(Rails.root, 'lib', 'tasks', 'scheduler.rake')

describe 'scheduler' do
  self.use_transactional_fixtures = false
  # let!(:user) { FactoryGirl.create(:user) }
  # let!(:site) { FactoryGirl.create(:site, user: user) }

  context 'when running tasks' do
    describe '#northbay_forecast' do
      it 'sends northbay_forecast' do
        begin
          Rake::Task['scheduler:northbay_forecast'].invoke
        rescue => e
          pp e
        end
      end
    end

    describe '#pop_alert' do
      it 'sends pop_alert' do
        pending 'redo rake spec'
        Rake::Task['scheduler:pop_alert'].invoke
      end
    end

    describe '#check_pop_alert' do
      it 'checks for pop_alert' do
        pending 'redo rake spec'
        Rake::Task['scheduler:check_pop_alert'].invoke
      end
    end

    describe '#daily_mailer' do
      it 'sends daily_mailer' do
        pending 'redo rake spec'
        Rake::Task['scheduler:daily_mailer'].invoke
      end
    end

    describe '#pester_admins' do
      it 'sends pester_admins' do
        pending 'redo rake spec'
        Rake::Task['scheduler:pester_admins'].invoke
      end
    end

    describe '#staging_mailer' do
      it 'sends staging_mailer' do
        pending 'redo rake spec'
        Rake::Task['scheduler:staging_mailer'].invoke
      end
    end

    describe '#mailout' do
      it 'sends mailout' do
        begin
          Rake::Task['scheduler:mailout'].invoke
        rescue => e
          pp e
        end
      end
    end

    describe '#thankyou' do
      it 'sends thankyou' do
        Rake::Task['scheduler:thankyou'].invoke
      end
    end

    describe '#noaa_table' do
      it 'caches noaa_table' do
        pending 'redo rake spec'
        Rake::Task['scheduler:noaa_table'].invoke
      end
    end

    describe '#wg_table' do
      it ' caches wg_table' do
        pending 'redo rake spec'
        Rake::Task['scheduler:wg_table'].invoke
      end
    end
  end
end
