module Restrict_users_scenario


  def restrict_user
    if page.has_content?("Admin lock option")
      click_on("Admin lock option")
      element = find_all(:link, text: "disapprove").last
      element.click
      complete "disapproved a user!" if page.assert_text"User has been disapproved"
    else
      failed("This user cannot approve/disapprove other users!")
    end

  end

  def approve_user
    if page.has_content?("Admin lock option")
      click_on("Admin lock option")
      element = find_all(:link, text: "approve").last
      element.click
      complete "approved a user!" if page.has_no_content?("User has been disapproved")
    else
      failed("This user cannot approve/disapprove other users!")
    end
  end
end