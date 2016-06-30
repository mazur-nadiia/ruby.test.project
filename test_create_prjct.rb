require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class CreateProject <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'http://demo.redmine.org'
    sleep 1
  end

  def test_create_project

    register_result = register_user
    actual_text = @driver.find_element(:xpath => '//*[@id="loggedas"]/a').text
    assert_equal(register_result[0], actual_text)
    project_name = 'project_247_'+ rand(99999).to_s
    project_description = 'description for ' + project_name
    create_project(project_name, project_description)
    verify_flash_notice_text("Successful creation.")
  end



  def teardown
    @driver.quit
  end

end