#Module is created for being able to call logger inside methods
# and to pass parameters to log
module Logging
  def logger
    Logging.logger
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end
