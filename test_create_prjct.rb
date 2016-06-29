require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class CreateProject <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'https://demo.redmine.org'
    sleep 1
  end

  def test_create_project

    login = '247test'+rand(99999).to_s
    password = login
    mail = login+'@re.cd'
    register_user(login, password, login, login, mail)
    sleep 5
    actual_text = @driver.find_element(:xpath => '//*[@id="loggedas"]/a').text
    assert_equal(login, actual_text)
    project_name = 'project_247_'+ rand(99999).to_s
    project_description = 'description for ' + project_name

    create_project(project_name, project_description)

    expected_text = "Successful creation."
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end

end