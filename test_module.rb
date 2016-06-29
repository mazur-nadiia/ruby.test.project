module TestModule
  def register_user_random
    @driver.navigate.to 'https://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}
    login = 'user247_' + rand(99999).to_s
    password = rand(999999999).to_s
    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys password
    @driver.find_element(:id, 'user_password_confirmation').send_keys password
    @driver.find_element(:id, 'user_firstname').send_keys '123wq'
    @driver.find_element(:id, 'user_lastname').send_keys '123wq'
    @driver.find_element(:id, 'user_mail').send_keys (login + '@247.test.com')

    @driver.find_element(:name, 'commit').click
    return login, password
  end


  def register_user(login, password, firstname, lastname, mail)
    @driver.navigate.to 'https://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}
    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys password
    @driver.find_element(:id, 'user_password_confirmation').send_keys password
    @driver.find_element(:id, 'user_firstname').send_keys firstname
    @driver.find_element(:id, 'user_lastname').send_keys lastname
    @driver.find_element(:id, 'user_mail').send_keys (mail)

    @driver.find_element(:name, 'commit').click
  end

  def user_login (username, password)
    @driver.find_element(:class, 'login').click
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
    @driver.find_element(:xpath => '//input[@type="submit" and @name="commit"]').click
  end

  def create_project(project_name, project_description)
    @driver.find_element(:class, 'projects').click
    sleep 1
    @driver.find_element(:class, 'icon-add').click
    @driver.find_element(:id, 'project_name').send_keys project_name
    @driver.find_element(:id, 'project_description').send_keys project_description
    @driver.find_element(:xpath => '//input[@type="submit" and @name="commit"]').click
  end
end