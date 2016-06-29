require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class ChangePassword <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_change_password
    results = register_user_random
    new_password = rand(9999999)
    change_password(results[1], new_password)
    expected_text = "Password was successfully updated."
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    user_logout
    @driver.quit
  end

end