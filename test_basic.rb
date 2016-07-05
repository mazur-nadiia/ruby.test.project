require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class ChangePassword <Test::Unit::TestCase
  include TestModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_change_password
    results = register_user
    new_password = rand(9999999)
    change_password(results[1], new_password)
    verify_flash_notice_text("Password was successfully updated.")
  end


  def test_create_issue_bug
    user_login('nma', '1234567')
    create_project
    issue_name = create_issue("Bug")
    verify_flash_notice_contains(['Issue', 'created.'])
    verify_issue_created(issue_name)
  end

  def test_create_issue_feature
    user_login('nma', '1234567')
    create_project
    issue_name = create_issue("Feature")
    verify_flash_notice_contains(['Issue', 'created.'])
    verify_issue_created(issue_name)
  end

  def test_create_issue_support
    user_login('nma', '1234567')
    create_project
    issue_name = create_issue("Support")
    verify_flash_notice_contains(['Issue', 'created.'])
    verify_issue_created(issue_name)
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

  def test_create_version
    user_login('nma', '1234567')
    project_name = 'test_project' + rand(999999).to_s
    project_description = 'test_description' + rand(9999).to_s
    create_project(project_name, project_description)
    create_version
    verify_flash_notice_text("Successful creation.")
  end

  def test_with_registration
    results = register_user
    user_logout
    user_login results[0], results[1]
    @wait.until {@driver.find_element(:xpath => '//*[@id="loggedas"]/a')}
    actual_text = @driver.find_element(:xpath => '//*[@id="loggedas"]/a').text
    assert_equal(results[0], actual_text)
  end

  def test_log_out
    register_user
    user_logout
    @wait.until { @driver.find_element(:class, 'login')}
    login_button = @driver.find_element(:class, 'login')
    assert(login_button.displayed?)
  end

  def test_registration
    register_user
    expected_text = "Your account has been activated. You can now log in."
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    begin
      user_logout
    rescue
      puts "User is already loged out"
    end
    @driver.quit
  end

end