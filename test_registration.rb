require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class TestRegistration <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_positive
    register_user
    expected_text = "Your account has been activated. You can now log in."
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end

end