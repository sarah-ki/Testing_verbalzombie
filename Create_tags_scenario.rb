module Create_tags_scenario
  def create_tag(name="test")

    click_on("Tags")

    if !(page.has_content?(name))
      complete("Tag does not exist yet")
      fill_in("tag_name", with: name)
    else
      fill_in("tag_name", with: name)
      failed("The selected Tag already existed")
      return
    end

    click_on("Submit")
    visit current_path

    if page.assert_text(name)
      complete("Tag has been created")
    end

  end
end