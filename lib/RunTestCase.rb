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
  $run_browser = 'chrome'
  $keyword = 'potato'

  # set up driver and open browser
  init_test = TestsSetUp.new
  driver = init_test.open_browser($run_browser)
  driver.manage.timeouts.implicit_wait = 10

  #initialise classes
  google_page = GoogleSearchResults.new(driver)
  bing_page = BingSearchResults.new(driver)
  browser = BaseBrowser.new(driver)
  process_data = ProcessData.new
  google_mapped_results = Array.new
  bing_mapped_results = Array.new

  #test-case steps
  browser.delete_cookie
  browser.open_page('http://www.google.com')

  google_page.do_search($keyword)
  google_search_results = google_page.get_search_results_from_first_page

  google_page.check_chrome_gettext(google_search_results) #title / url / desc .


  process_data.parse_search_results_url_title_desc(google_search_results, google_mapped_results)
  process_data.check_have_keyword(google_mapped_results, $keyword)
  process_data.log_if_search_results_contain_keyword(google_mapped_results, $keyword)

  browser.open_page('http://www.bing.com')
  bing_page.do_search($keyword)
  bing_search_results = bing_page.get_search_results_from_first_page
  process_data.parse_search_results_url_title_desc(bing_search_results, bing_mapped_results)
  process_data.check_have_keyword(bing_mapped_results, $keyword)
  process_data.log_if_search_results_contain_keyword(bing_mapped_results, $keyword)

  process_data.find_common_search_results(google_mapped_results, bing_mapped_results)

  init_test.tearDown
end