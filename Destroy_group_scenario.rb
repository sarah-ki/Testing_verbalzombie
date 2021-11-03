module Destroy_group_scenario

  # uncomment sleep if you have no idea why it fails
  def destroy_group
    click_on "Groups"

    if page.has_content?("Destroy")
      nr_before_del = find_all(:link, "Destroy").count
      click_on("Destroy", match: :first)
      accept_alert
      sleep(3)
      visit current_path
      # sleep(3)
      nr_after_del = find_all(:link, "Destroy").count
      # sleep(3)
      if nr_after_del < nr_before_del
        complete("#{find_all(:link, "Destroy").count} left after successfully destroying one!")
      else
        failed("#{find_all(:link, "Destroy").count} left. None could be destroyed")
      end

    else
      failed("This user is not allowed to Destroy Groups or there are currently no groups available for destruction")
    end
  end
end