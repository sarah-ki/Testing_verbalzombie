module Search_and_show_meals_scenario

  def search_meal(title = 'Chilli')
    click_on('All Meals')
    fill_in('query', with: title)
    click_on('Search')

    page.assert_text('Search Results')

    if (page.has_content?(title))
      complete('At least one Result for the search has bees found')
    else
      failed('The search did not return any results')
    end
  end

  def show_meal(title = 'Pizza Caprese')
    click_on('All Meals')

    if page.has_link?(title, exact: true)
      click_on(title)
      page.assert_text('Title of the Meal')
      complete('Meal is showing')
      return
    else
      while (page.has_content?('Next Page'))
        click_on('Next Page')
        if (page.has_link?(title, exact: true))
          click_on(title)
          if page.assert_text('Title of the Meal')
            complete('Meal is showing')
            return
          end

        end
      end
      failed('This Meal does not exist')
    end

  end

  # With multiple Results matching exact first one will be selected to be shown,
  # With none matching exact fist one matching not exact will be shown,
  # With no results matching no result will be shown
  def search_and_show_meal(title = 'Pizza Salami')
    click_on 'All Meals'
    fill_in('query', with: title)
    click_on('Search')
    sleep(2)

    results = find_all(:link, text: title)
    if results.empty?
      failed('No matching results could be found for search_and_show_meal!')
    else
      results.each do |result|
        complete("Search test has found #{result.text}!")
      end

      if page.has_link?(text: title, exact_text: true)
        complete('At least one full match has been found')
        click_link(text: title, exact_text: true, match: :first)
      elsif page.has_link?(title)
        click_link(text: title, match: :first)
        complete('At least one part match has been found')
      else
        failed('No matched for the given search_and_show_meal parameter have been found')
      end

    end

  end
end