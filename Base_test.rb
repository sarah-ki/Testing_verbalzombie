require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'capybara-screenshot'

require_relative 'Display_helper' # helps displaying useful information like results for users

require_relative 'Minitests' # Shows short terminal results

require_relative 'Create_group_scenario'
require_relative 'Join_group_scenario'
require_relative 'Create_meal_scenario'
require_relative 'Create_tags_scenario'
require_relative 'Search_and_show_meals_scenario'
require_relative 'Restrict_users_scenario'
require_relative 'Destroy_group_scenario'

class Base_test
  include Capybara::DSL
  include Display_helper

  include Create_group_scenario
  include Join_group_scenario
  include Create_meal_scenario
  include Create_tags_scenario
  include Search_and_show_meals_scenario
  include Restrict_users_scenario
  include Destroy_group_scenario

  print 'Good evening!'
  Capybara.configure do |capybara|
    capybara.default_driver = :selenium
    capybara.app_host = 'http://localhost:3000'
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  def play
    # sign_in_admin
    sign_in_normal
    # sign_in_restricted

    start_scenarios
  end

  def sign_in_admin
    if page.has_content?('Sign_out')
      click_on('Sign_out')
    else
      click_on('Sign_in', match: :first)
      fill_in('user_email', with: 'admin@example.com')
      fill_in('user_password', with: 'password')
      click_on('Log in')
    end
    if page.assert_text('Sign_out')
      complete('Admin User is Logged in')
    else
      failed('Problem signing in admin User')
    end
  end

  def sign_in_normal
    if page.has_content?('Sign_out')
      click_on('Sign_out')
    else
      click_on('Sign_in', match: :first)
      fill_in('user_email', with: 'normal@example.com')
      fill_in('user_password', with: 'password')
      click_on('Log in')
    end
    if page.assert_text('Sign_out')
      complete('Normal User is Logged in')
    else
      failed('Problem signing in normal User')
    end
  end

  def sign_in_restricted

    if page.has_content?('Sign_out')
      click_on('Sign_out')
    else
      click_on('Sign_in', match: :first)
      fill_in('user_email', with: 'restricted@example.com')
      fill_in('user_password', with: 'password')
      click_on('Log in')
    end

    if page.has_content?('Sign_out') or (page.has_content?('Sign_in'))
      complete('restricted User is Logged in')
    else
      failed('Problem authenticating restricted User')
    end

  end

  # Here you can uncomment/comment the single tests
  def start_scenarios()

    create_group("The entire Crew")
    join_group
    create_meal("Pizza Salami")
    # create_meal("")
    create_tag('test')

    search_meal
    show_meal
    search_and_show_meal

    restrict_user
    approve_user

    destroy_group
  end

  def show_logs
    Minitests.new.read_files
  end

  def begin_testphase
    @logs = File.new("logs/#{Time.now}_logs.txt", 'w')
    visit '/'
    play if ARGV.empty?
    @logs.close
    show_logs
  end

  def reset
    visit '/'
  end
end

Base_test.new.begin_testphase



