require 'selenium-webdriver'
require 'pry-byebug'

service = Selenium::WebDriver::Service.chrome(path: './chromedriver')
driver = Selenium::WebDriver.for :chrome, service: service
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
begin
  driver.get 'https://site.qr-row.staging.goquo.io/'

  driver.title # => 'Google'

  banner = driver.find_element(:id, 'cmCloseBanner')
  banner.click
  hotelBtn = driver.find_element(:xpath, '//div[@data-slick-index=3]')
  hotelBtn.click

  inputSearchBox = driver.find_element(:xpath, '//input[@placeholder="Destination, hotel, landmark or airports"]')
  inputSearchBox.send_keys 'DOH'
  sleep 5
  inputSearchBox.click

  resultSearchBox = driver.find_elements(:xpath, '//div[@class="flight-result-ddr__item found"]')

  firstResult = resultSearchBox.first()
  firstResult.click

  searchBtn = driver.find_element(:id, 'btnSubmitSearchFormHotel')
  searchBtn.click

  element = wait.until { driver.find_elements(:xpath => '//a[@data-tracking="btn-select-hotel"]') }

  element.first().click

  binding.pry
ensure
  driver.quit
end