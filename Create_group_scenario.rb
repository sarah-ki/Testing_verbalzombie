module Create_group_scenario

  def create_group(name = 'The Snakes')

    description = 'SSSSSSSSSSSsssssssssssssssssssssssssss'

    click_on('Groups', match: :first)
    sleep(2)
    click_on('New Group')

    if page.assert_text('preselected')
      complete('Opened new Group page')
    else
      failed('Problem displaying Site to create a new group')
      return
    end

    fill_in('group_description', with: description)
    fill_in('group_name', with: name)
    select('admin@example.com')

    click_on('Create Group')
    visit('/groups')
    sleep(5)

    if page.assert_text(name)
      complete('Group has been created')
    end

  end

end
