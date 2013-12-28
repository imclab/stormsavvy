worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  Sidekiq.configure_client do |config|
    config.redis = ConnectionPool.new(:size => 1, :timeout => 1) do
      # MyRedisWrapper.new(...)
    end
  end
end

=begin
  # old unicorn setup
  worker_processes 4 # amount of unicorn workers to spin up
  timeout 30         # restarts workers that hang for 30 seconds
  preload_app true

  # handles unicorn process on heroku: http://goo.gl/YiWOA
  before_fork do |server, worker|

    Signal.trap 'TERM' do
      puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
      Process.kill 'QUIT', Process.pid
    end

    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
  end

  after_fork do |server, worker|

    Signal.trap 'TERM' do
      puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
    end

    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection

  end
=end
