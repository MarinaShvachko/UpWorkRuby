require 'selenium-webdriver'
require 'webdrivers'
require 'logger'

class TestsSetUp
  include Logging

  #Open browser based on variable
  def open_browser(name_of_browser)
    logger.info "Run browser <#{name_of_browser}>"
    if name_of_browser.downcase.eql?"chrome"
      @driver = Selenium::WebDriver.for :chrome
    elsif name_of_browser.downcase.eql?"firefox"
      @driver = Selenium::WebDriver.for :firefox
    else
      raise Exception.new 'Error, possible values for driver name: firefox or chrome'
    end
  end

  #Close driver
  def tearDown
    @driver.quit
  end

end
