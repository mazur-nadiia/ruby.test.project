require 'test-unit'
require 'selenium-webdriver'
require_relative 'test_module'

class TestBasic <Test::Unit::TestCase
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
    actual_text = @driver.find_element(:id, 'loggedas').text
    assert_equal("Logged in as "+ register_result[0], actual_text)
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
    @wait.until {@driver.find_element(:id, 'loggedas')}
    actual_text = @driver.find_element(:id, 'loggedas').text
    assert_equal("Logged in as "+ results[0], actual_text)
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

  def test_random_action
    register_user
    project_name = create_project()
    create_bug_issue = rand(2)
    if (create_bug_issue != 0)
      create_issue("Bug")
    end
    open_project_tab(project_name)
    element = is_element_present_by_class("tracker")
    if element
      add_element_to_watchers(element)
    else
      issue = create_issue("Bug")
      add_element_to_watchers_via_button
      verify_issue_created(issue)
      verify_user_is_a_watcher(issue)
    end
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
