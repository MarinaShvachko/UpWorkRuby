require 'selenium-webdriver'
require 'webdrivers'
require File.expand_path(".", 'lib/pages/BasePage.rb')
require_relative File.expand_path(".", 'lib/log/Logging')

#Class represent search results of Microsoft Bing search engine
class BingSearchResults < BasePage
  include Logging

  def initialize(driver)
    super
  end

  PATH_TO_SEARCH_RESULTS = "//ol//li[@class='b_algo']" #tag.class doesn't work
  PATH_TO_FULL_SEARCH_RES = "#b_results > li"

  #get search result data, excluding nested search items, search engine suggestions, embedded videos
  def get_search_results
    enough_results_present?(PATH_TO_FULL_SEARCH_RES)
    logger.info "Parse first 10 search result items. Exclude nested search items, search engine suggestions, embedded videos"
     wait = Selenium::WebDriver::Wait.new(timeout: 10)
     wait.until{@driver.find_elements(:xpath, PATH_TO_SEARCH_RESULTS)}
  end

  # def check_bing_gettext(arr)
  #   arr.each {|x| puts x.text + "---------------------------------------"}
  # end

end
