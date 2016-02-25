module App
  require 'net/http'
  def self.acts_like_a_development_app?
    development? || test?
  end

  def self.does_not_act_like_a_development_app?
    !acts_like_a_development_app?
  end

  def self.development?
    Rails.env.development?
  end

  def self.test?
    Rails.env.test?
  end

  def self.connected_to_youtube?
    return true unless CHECK_YOUTUBE
    connected = false
    AppLogging.say('Testing YouTube Connection') do
      connected = test_connection('www.youtube.com')
      AppLogging.say("Connected: #{connected.to_s}", 1)
    end
    connected
  end

  def self.test_connection(server, ping_count=2, timeout = 3)
    result = `ping -q -t #{timeout} -c #{ping_count} #{server}`
    $?.exitstatus == 0 ? true : false
  end
end
