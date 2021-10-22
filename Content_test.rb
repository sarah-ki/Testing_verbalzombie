module Content_test

  def find_on_page(items)
    begin
      items.each do |item|
        self.reset
        click_on(item, match: :first)
      end

      complete('All items found on page')
    rescue Capybara::ElementNotFound => e
      failed("not all items found on page: #{page.current_url}")
    end
    reset
  end

  def find_in_list(items)
    begin
      within 'table.table' do
        items.each { |item|
          reset
          click_on(item, match: :first)
          complete("\"#{item}\" found in list")
        }
      end
    rescue Capybara::ElementNotFound => e
      failed("not all items found in list: #{page.current_url}")
    end
    reset
  end

  def page_content(content)
    # if page.has_content?(title)
    if page.assert_text(content)
      complete("#{page.current_url} contains \"#{content}\"")
    else
      failed(" Expected #{page.current_url} content not found: #{content}")
    end
    reset
  end

end