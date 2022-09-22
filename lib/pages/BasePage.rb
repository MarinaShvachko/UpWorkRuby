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

  PATH_TO_SEARCH_FIELD = 'q'

  #find a search field, type a search word and search
  def do_search(key_word)
    logger.info "Search using <#{key_word}>"
    @driver.find_element(:name, PATH_TO_SEARCH_FIELD).send_keys key_word, :return
  end

  private
  #Check on the page >= 10 search results
  #Change sleep on appropriate method, displayed? and wait don't work
  def enough_results_present?(path_to_elements)
    sleep(2)
    num = @driver.find_elements(:css, path_to_elements)

    if num.length() < 10
      @driver.quit
      raise Exception.new "There are less then 10 search results"
    end
  end

end
