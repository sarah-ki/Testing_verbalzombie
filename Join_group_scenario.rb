module Join_group_scenario

  def join_group
    click_on("Groups", match: :first)
    sleep(2)
    click_on("Show", match: :first)

    if page.assert_text("Join")
      complete("Opened show Group page")
    else
      failed("Problem displaying Site to show this group")
      return
    end
    click_on("Join")
    if page.has_content?("User joined")
      complete("Successfully joined a group")
    elsif page.has_content?("User already in group")
      failed("Joining group failed. User already in group")
    end

  end


end