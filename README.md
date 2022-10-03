## This is home task from UpWork. Code was created and tested on MacBook
### Language is used:
* Ruby
### Libraries are used:
* selenium-webdriver
* uri

## To start test:
* Open class lib/RunTestCase.rb
* Specify browser ('chrome' or 'firefox', case-insensitive) in variable run_browser
* Specify keyword in variable keyword

## To get different test results
* To have < 10 test results set keyword = 'skjfhlasdjkghskdljfgds;kfgjhsdf;kjghdfkjghlsdk'
* To have result without keyword might work 'rain' if there is no rain according the weather forecast

### Comments:
* As I didn't work with Ruby and didn't use additional libraries for this framework there are a lot of TODO:
1. Add method 'go to' to the second page if search result on the first page > 0 and < 10
2. Add encapsulation (study how in works in Ruby)
3. Study how organise set up method for initialising drivers without addition libraries
4. Add config file