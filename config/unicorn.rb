require File.dirname(__FILE__)+'/application'
preload_app true

if ::Rails.env.development?
  worker_processes 1
else
  worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
end

timeout Integer(ENV['WEB_TIMEOUT'] || 15)

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
