require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

def test_log_out
  register_user
  user_logout
  sleep 3
  login_button = @driver.find_element(:class, 'login')
  assert(login_button.displayed?)
end