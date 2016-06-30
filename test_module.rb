module TestModule

  def register_user(login = 'user247_' + rand(99999).to_s,
                    password = rand(999999999).to_s, firstname = 'user247_' + rand(99999).to_s,
                    lastname = 'user247_' + rand(99999).to_s, mail = 'user247_' + rand(99999).to_s + '@247qe.com')
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}
    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys password
    @driver.find_element(:id, 'user_password_confirmation').send_keys password
    @driver.find_element(:id, 'user_firstname').send_keys firstname
    @driver.find_element(:id, 'user_lastname').send_keys lastname
    @driver.find_element(:id, 'user_mail').send_keys (mail)

    submit

    return login, password
  end

  def user_login (username, password)
    @driver.find_element(:class, 'login').click
    sleep 2
    @driver.find_element(:id, 'username').send_keys username
    @driver.find_element(:id, 'password').send_keys password
    @driver.find_element(:xpath => '//input[@type="submit" and @name="login"]').click
  end

  def user_logout
    @driver.find_element(:class, 'logout').click
  end

  def change_password(old_password, new_password)
    @driver.find_element(:class, 'my-account').click
    @driver.find_element(:class, 'icon-passwd').click
    @driver.find_element(:id, 'password').send_keys old_password
    @driver.find_element(:id, 'new_password').send_keys new_password
    @driver.find_element(:id, 'new_password_confirmation').send_keys new_password
    submit
  end

  def create_project(project_name = 'test_project' + rand(9999).to_s,
                     project_description ='test_description' + rand(9999).to_s)
    @driver.find_element(:class, 'projects').click
    sleep 1
    @driver.find_element(:class, 'icon-add').click
    sleep 1
    @driver.find_element(:id, 'project_name').send_keys project_name
    @driver.find_element(:id, 'project_description').send_keys project_description
    sleep 1
    submit
    return project_name
  end

  def create_version(version_name = 'test version'+ rand(999).to_s, version_description = 'test description')
    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:xpath => "//a[text()='New version']").click
    @driver.find_element(:id, 'version_name').send_keys version_name
    @driver.find_element(:id, 'version_description').send_keys version_description
    submit

  end

  def verify_flash_notice_text(expected_text)
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def verify_flash_notice_partial_text(expected_text)
    actual_text = @driver.find_element(:id, 'flash_notice').text
      expected_text.each do |i|
      assert_contains i, actual_text
    end
  end

  def create_issue(issue_tracker_id, subject, description)
    @driver.find_element(:class, 'new-issue').click
    select = @driver.find_element(:id, 'issue_tracker_id')
    select.click
    select.find_elements( :tag_name => "option" ).find do |option|
      option.text == issue_tracker_id
    end.click
    sleep 1
    @driver.find_element(:id, 'issue_subject').send_keys subject
    @driver.find_element(:id, 'issue_description').send_keys description

    submit
  end

  def submit
    @driver.find_element(:xpath => '//input[@type="submit" and @name="commit"]').click
  end

  def verify_issue_created(issue_name)
    @driver.find_element(:class , 'projects').click
    @driver.find_element(:xpath => "//a[text()='View all issues']").click

    List<WebElement> list = @driver.findElement(:xpath => "//.issues[contains(text(),'" + issue_name + "')]");
    Assert.assertTrue("Text not found!", list.size() > 0);

  end

end