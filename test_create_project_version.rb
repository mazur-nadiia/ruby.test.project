require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class CreateVersion <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'http://demo.redmine.org'
    sleep 1
  end

  def test_create_version
    user_login('nma', '1234567')
    project_name = 'test_project' + rand(999999).to_s
    project_description = 'test_description' + rand(9999).to_s
    create_project(project_name, project_description)
    create_version
    verify_flash_notice_text("Successful creation.")
end

  def teardown
    @driver.quit
  end

end