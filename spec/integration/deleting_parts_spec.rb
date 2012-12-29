require 'spec_helper'

feature "Deleting parts" do
  scenario "Deleting a part" do
    Factory(:part, :desc => "HP DL160G6")
    visit "/"
    click_link "HP DL160G6"
    click_link "Delete Part"
    page.should have_content("Part has been deleted.")
    visit "/"
    page.should_not have_content("HP DL160G6")
  end
end
