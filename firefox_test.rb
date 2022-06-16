require 'selenium-webdriver'

Selenium::WebDriver::Firefox.driver_path = "D:/drivers_for_selenium/geckodriver-v0.31.0-win64/geckodriver.exe"

driver = Selenium::WebDriver.for :firefox
driver.get("https://www.onlyoffice.com/")

dropDownMenu = driver.find_element(:id,'navitem_about')
option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
option.select_by(:id,'navitem_about_contacts').click
sleep(10)
