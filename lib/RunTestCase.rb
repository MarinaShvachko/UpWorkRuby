require 'selenium-webdriver'
require 'webdrivers'
require_relative 'utils/ProcessData.rb'
require_relative '../lib/browsers/BaseBrowser.rb'
require_relative 'pages/googlePages/GoogleSearchResults.rb'
require_relative 'pages/bingPages/BingSearchResults.rb'
require_relative 'TestsSetUp.rb'
include Selenium::WebDriver::Support

#Class to run test-case
class RunTestCase < TestsSetUp
  #choose browser, options: 'chrome' or 'firefox', specify keyword
  run_browser = 'chrome'
  keyword = 'potato'

  # set up driver and open browser
  init_test = TestsSetUp.new
  driver = init_test.open_browser(run_browser)
  driver.manage.timeouts.implicit_wait = 10
  driver.manage.window.maximize

  #initialise classes
  google_page = GoogleSearchResults.new(driver)
  bing_page = BingSearchResults.new(driver)
  browser = BaseBrowser.new(driver)
  process_data = ProcessData.new

  #test-case steps
  browser.delete_cookie
  browser.open_page('http://www.google.com')

  google_page.fill_search_field(keyword)
  google_page.confirm_search
  google_search_results = google_page.get_search_results ##initialise
  google_mapped_results = process_data.parse_search_results(google_search_results)
  process_data.check_have_keyword(google_mapped_results, keyword)
  process_data.keyword_in_elements?(google_mapped_results, keyword)

  browser.open_page('http://www.bing.com')
  bing_page.fill_search_field(keyword)
  bing_page.confirm_search
  bing_search_results = bing_page.get_search_results
  bing_mapped_results = process_data.parse_search_results(bing_search_results)
  process_data.check_have_keyword(bing_mapped_results, keyword)
  process_data.keyword_in_elements?(bing_mapped_results, keyword)

  process_data.common_search_results(google_mapped_results, bing_mapped_results)

  init_test.tearDown
end