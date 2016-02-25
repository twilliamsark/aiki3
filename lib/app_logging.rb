module AppLogging
  def self.say(message, indent = 0, logger = Rails.logger, &block)
    do_say(message, indent, logger, &block)
  end

  def self.do_say(message, indent = 0, logger = Rails.logger, &block)
    if block_given?
      say(message)
      result = yield(block)
      say('Done')
      return result
    else
      prefix = "#{'  ' * indent} - "
      # puts "#{prefix}#{message}"
      logger.info "#{prefix}#{message}"
    end
  end
end
