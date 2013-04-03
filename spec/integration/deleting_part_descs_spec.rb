require 'spec_helper'

feature "Deleting part descriptions" do
  scenario "delete part description" do
    create(:part_desc, desc: "HP DL160G6")
    visit "/"
    click_link "Part Descriptions"
    click_link "HP DL160G6"
    click_link "Delete"
    page.should have_content("Part Description has been deleted.")
    visit part_descs_url
    page.should_not have_content("HP DL160G6")
  end
end
