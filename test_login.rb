require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class TestLogin <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_with_registration
    results = register_user_random
    user_logout
    user_login results[0], results[1]
    sleep 5
    actual_text = @driver.find_element(:xpath => '//*[@id="loggedas"]/a').text
    assert_equal(results[0], actual_text)
  end

  def teardown
    @driver.quit
  end

end