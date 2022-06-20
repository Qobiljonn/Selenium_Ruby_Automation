require 'selenium-webdriver'
require 'rspec/retry'
require 'csv'
require 'capybara'

Selenium::WebDriver::Firefox.driver_path = "D:/drivers_for_selenium/geckodriver-v0.31.0-win64/geckodriver.exe"
driver = Selenium::WebDriver.for :firefox
Capybara.register_driver :driver do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  client = Selenium::WebDriver::Http::Default.new
  client.timeout = 120
  Capybara::Selenium::Driver.new(app,browser: firefox, profile: profile, http_client: client)
end

driver.get("https://www.onlyoffice.com/")
#RSpec.configure do |config|
# config.verbose_retry = true
# config.default_retry_count = 3
#end
#wait = Selenium::WebDriver::Wait.new(:timeout => 20)

dropDownMenu = driver.find_element(:xpath,'/html/body/div[2]/form/div[3]/header/div/nav/div/ul/li[6]/a')
driver.action.move_to(dropDownMenu).perform
contactsOption = driver.find_element(:xpath,'/html/body/div[2]/form/div[3]/header/div/nav/div/ul/li[6]/div/ul/li[1]/a[8]')
driver.action.click(contactsOption).perform
sleep(20)
countries = driver.find_elements(:class,'region')
company_names = driver.find_elements(:css,'div.companydata:nth-child(2) > span:nth-child(2) > b:nth-child(1)')

puts company_names.length
countries_to_string = Array.new
(0..countries.length).each{|index|
  if countries[index].nil? == false
    countries_to_string[index] = countries[index].text
  end
}
CSV.open("myfile.csv","w") do |csv|
 csv << countries_to_string
end
