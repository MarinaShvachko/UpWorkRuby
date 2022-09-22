require 'selenium-webdriver'
require 'webdrivers'
require_relative File.expand_path(".", 'lib/log/Logging')

#Class with common methods for web pages,
#this methods do not depend on web site
class BasePage
  include Logging

  def initialize(driver)
    @driver=driver
  end

  #Check on the page >= 10 search results
  #Change sleep on appropriate method, displayed? and wait don't work
  private
  def enough_results_present?(path_to_elements)
    sleep(2)
    num = @driver.find_elements(:css, path_to_elements)

    if num.length < 10
      @driver.quit
      raise Exception.new "There are less then 10 search results"
    end
  end

end
