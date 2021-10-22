require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'capybara-screenshot'

require_relative 'Display_helper' # helps displaying useful information like results for users
require_relative 'Content_test' # searches for content on page / main-page-table (module)
require_relative 'Various_test' # Single, no category Tests
require_relative 'Minitests' # Shows short terminal results

class Base_test
  include Capybara::DSL
  include Display_helper
  include Various_test
  include Content_test

  print 'Good evening!'
  Capybara.configure do |capybara|
    capybara.default_driver = :selenium
    capybara.app_host = 'http://localhost:3000'
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  def play_all
    play_content
    play_various
  end

  def play_content
    #Check main page title
    page_content('Homepage')
    # Look for items in list on entire main page or just in table
    items = %w[Group Title Tags Enjoy!]
    find_on_page(items)
  end

  def play_various
    # Test 2 : check if word exists or e.g. page not found
    check_for_title(80, 90)
    # Test 3 : Fill in field
    filling_in('Neue geistig Errungenschaft', 'Gigsi Gaxi')
    # Handling Exception after clciking on 'Alle' bzw. no Exception after clicking 'Neuste'
    # catch_rt_all # uncomment to check for button 'Alle'
    catch_rt_all('Neuste')
  end
  def show_logs
    Minitests.new.read_files
  end
  def begin_testphase
    @logs = File.new("logs/#{Time.now}_logs.txt", 'w')
    visit '/'
    play_all if ARGV.empty?
    play_content if ARGV.include?("content")
    play_various if ARGV.include?("various")
    @logs.close
    show_logs if ARGV.include?("show")
    show_logs if ARGV.empty?
  end
  def reset
    visit '/'
  end
end
Base_test.new.begin_testphase



