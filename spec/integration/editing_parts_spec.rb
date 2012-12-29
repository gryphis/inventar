require 'spec_helper'

feature "Editing Parts" do
  before do
    Factory(:part, :desc => "HP DL160G6")
    visit "/"
    click_link "HP DL160G6"
    click_link "Edit Part"
  end
  scenario "Updating a part" do
    fill_in "Description", :with => "HP DL160G8"
    click_button "Update Part"
    page.should have_content("Part has been updated.")
  end
  scenario "Updating a part with invalid attributes is bad" do
    fill_in "Description", :with => ""
    click_button "Update Part"
    page.should have_content("Part has not been updated.")
  end

end
