module Create_meal_scenario

  def create_meal(title="Noodles")

    information = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to"

    click_on("New Meal", match: :first)
    fill_in("meal_title", with: title)
    select( "The entire Crew", from: "meal_group_id")
    fill_in( "meal_recipe", with: information)
    select( "vegan", from: "meal_tag_ids")
    select( "spicy", from: "meal_tag_ids")
    click_on "Submit Changes"

    if page.assert_text("Success")
      complete("Meal has been created")
    end


  end

end