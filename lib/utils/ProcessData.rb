require 'uri'
require 'selenium-webdriver'
require_relative File.expand_path(".", 'lib/log/Logging')

#Class with methods for sorting and processing data
class ProcessData
  include Logging

  #Iterate WebElements, for each get text (string with title, url, description separated by \n),
  #Split text to have title, url, description,
  #Retunn Array with Arrays, each contains elements url, title, description
  def parse_search_results(array_to_pars)
    logger.info "Get attributes: url, title, short description from parsed search results"
    array_with_results = Array.new
    array_to_pars.each do |e|
      elements = e.text.split("\n")
      full_url_string = elements[1].split(" ")
      url = full_url_string[0]
      title = elements[0]
      description = elements[2]

      array_with_results.push(Array[url, title, description])
    end
    array_with_results
  end

  #Iterate Array with Arrays, check at least one element of each Array contains keyword. Case insensitive
  def check_have_keyword(search_results, key_word)
    logger.info "Make sure at least one attribute of each item from parsed search results contains <#{key_word}>"
    downcase_key_word = key_word.downcase
    length = search_results.length

    for i in 0..length-1 do
      _num = 1
      url = search_results[i][0].downcase
      title = search_results[i][1].downcase
      description = search_results[i][2].downcase

      if url.include?(downcase_key_word) || title.include?(downcase_key_word) || description.include?(downcase_key_word)
        _num=_num+1
      else
        raise Exception.new "Search result №" + _num.to_s + " don't contain <#{key_word}>. \nURL = " + url +
                              "\nTitle = " + title +
                              "\nDescription = " + description
        exit
      end
    end
  end

  #For each element in Array of Arrays write has the element keyword or not. Case insensitive
  def keyword_in_elements?(search_results, key_word)
    length = search_results.length
    logger.info "Log in which search results items and their attributes contain <#{key_word}> and which do not. \nNumber of search results is " + length.to_s + ":"
    for i in 0..length-1 do
      downcase_key_word = key_word.downcase
      url = search_results[i][0].downcase
      title = search_results[i][1].downcase
      description = search_results[i][2].downcase

      print url
      puts url.include?(downcase_key_word) ?  :" = URL contains keyword <#{key_word}>" : :" URL does not contain keyword <#{key_word}>"

      print title
      puts title.include?(downcase_key_word) ? :" = title contains keyword <#{key_word}>" : :" = title does not contain keyword <#{key_word}>"

      print description
      puts description.include?(downcase_key_word) ? :" = description contains keyword <#{key_word}>" : :" = description does not contain keyword <#{key_word}>"
   end
  end

  #Compare two Arrays (url and title) and return results found in both
  def common_search_results(first_array, second_array)
    logger.info "Compare stored results for both engines and list out the ones which were found in both search engines"
    first_array_url = Array.new
    second_array_url = Array.new

    #from Array with search results create Array with String url + title
    for i in 0..first_array.length()-1 do
      url = first_array[i][0]
      first_array_url.push(parse_url(url) + " - " + first_array[i][1])
    end

    #from Array with search results create Array with String url + title
    for i in 0..second_array.length()-1 do
      url = second_array[i][0]
      second_array_url.push(parse_url(url) + " - " + second_array[i][1])
    end

    #Compare Arrays and return results found in both
    common_search_results = first_array_url & second_array_url

    logger.info "Found " + common_search_results.length().to_s + " overlap in search engines: "  +  + common_search_results.to_s
  end

  #Get domain name from url
  private def parse_url(url)
    uri = URI(url)
    host = uri.host.to_s.start_with?('www.') ? uri.host[4..-1] : uri.host
    host.to_s
  end
end

