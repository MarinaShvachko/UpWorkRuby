require 'selenium-webdriver'
require 'webdrivers'
require 'logger'
require_relative File.expand_path(".", 'lib/log/Logging')

#Class contains common methods to use with any browser
class BaseBrowser
  include Logging

  def initialize(driver)
    @driver=driver
  end

  def delete_cookie
    logger.info "Clear cookies"
    @driver.manage.delete_all_cookies
  end

  #open web page
  def open_page(url)
    logger.info "Open #{url}"
    @driver.get url
  end

end
