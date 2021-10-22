module Various_test
# @param [Integer] beginning, first checked page number
# @param [Integer] stop, defines end for page checking
def check_for_title(beginning = 1,
                    stop = 6888)
  # warum kommt bei page 0 und reload jedesmal eine andere seite (mit einem anderen Wort?)
  while beginning < stop
    link = "/words/#{beginning.to_s}"
    visit link
    rules?
    if page.has_content?('Liste ekliger Wörter')
      complete("#{page.current_url} found while checking for title, #{page.title}")
    else
      failed("#{page.title} for #{page.current_url}")
    end
    beginning += 1
  end
  reset
end

# @param [String] field, name of the to-be-filled-in-placeholder
# @param [String] input, to-be-inserted-string
def filling_in(field='Neue geistige Errungenschaft', input="#{Time.now}")
  rules?
  begin
    fill_in(field, with: input)
    complete("Fill in Test #{page.current_url}")
  rescue Capybara::ElementNotFound => ce
    failed(" filling_in #{page.current_url}")
  end
  reset
end

# @param [String] btn, Button labeling
def catch_rt_all(btn='Alle')
  begin
    click_on(btn)
    complete("\"#{btn}\" clicked successfully")

  rescue Net::ReadTimeout => e
    failed("Read Timeout \"#{btn}\": #{page.current_url}")
  end
  reset
end

def rules?
  begin
    page.assert_text('Regeln: Habt Spaß, seid eklig, aber stets freundlich → tragt bitte keine Namen von Kollegen und keine Wörter aus Kundenprojekten ein.')
    complete("Rules for this page found: #{page.current_url}")
  rescue Capybara::ExpectationNotMet => ex
    failed("This page contains no rules! #{page.current_url}")
  end
end

end