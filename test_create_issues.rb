require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'


class CreateIssue <Test::Unit::TestCase
  include TestModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'http://demo.redmine.org'
    sleep 1
  end

  def test_create_issue_bug
    user_login('nma', '1234567')
    create_project
    create_issue("Bug", "test issue"+ rand(999).to_s, "test descirption" + rand(999).to_s)
    verify_flash_notice_partial_text(['Issue', 'created.'])
    #verify_issue_created(issue_name)
  end

  def test_create_issue_feature
    user_login('nma', '1234567')
    create_project
    create_issue("Feature", "test issue"+ rand(999).to_s, "test descirption" + rand(999).to_s)
    verify_flash_notice_partial_text(['Issue', 'created.'])
    #verify_issue_created(issue_name)
  end

  def test_create_issue_support
    user_login('nma', '1234567')
    create_project
    create_issue("Support", "test issue"+ rand(999).to_s, "test descirption" + rand(999).to_s)
    verify_flash_notice_partial_text(['Issue', 'created.'])
    #verify_issue_created(issue_name)
  end

  def assert_contains(expected_substring, string, *args)
    assert string.include?(expected_substring), *args
  end


  def teardown
    @driver.quit
  end

end