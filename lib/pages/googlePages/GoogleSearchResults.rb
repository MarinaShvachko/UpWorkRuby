require 'selenium-webdriver'
require 'webdrivers'
require File.expand_path(".", 'lib/pages/BasePage.rb')
require_relative File.expand_path(".", 'lib/log/Logging')

#Class represent search results of Google search engine
class GoogleSearchResults < BasePage
  include Logging

  def initialize(driver)
    super
  end

  SEARCH_FIELD            = {name: 'q'}
  PATH_TO_SEARCH_RESULTS  = {xpath: "//div[@class='v7W49e']/child::div[not(@class='ULSxyf')]"} #css example .v7W49e > div:not(.ULSxyf)
  PATH_TO_FULL_SEARCH_RES = ".v7W49e > div"

  #find a search field, type a search word and search
  def fill_search_field(key_word)
    logger.info "Search using <#{key_word}>"
    @driver.find_element(SEARCH_FIELD).send_keys key_word
  end

  def confirm_search
    @driver.find_element(SEARCH_FIELD).submit
  end

  #get search result data, excluding nested search items, search engine suggestions, embedded videos
  def get_search_results
    enough_results_present?(PATH_TO_FULL_SEARCH_RES)
    logger.info "Parse first 10 search result items. Exclude nested search items, search engine suggestions, embedded videos"
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until{@driver.find_elements(PATH_TO_SEARCH_RESULTS)}
  end

end
