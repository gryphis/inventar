require 'spec_helper'

feature "Editing Parts" do
  HP6 = "HP DL160G6"
  HP8 = "HP DL160G8"
  before do
    create(:part, desc: HP6)
    visit "/"
    click_link HP6
    click_link "Edit"
  end
  scenario "perform a valid update" do
    fill_in "Description", with: HP8
    click_button "Update Part"
    page.should have_content("Part has been updated.")
  end
  scenario "no update on invalid attributes" do
    fill_in "Description", with: ""
    click_button "Update Part"
    page.should have_content("Part has not been updated.")
  end
  scenario "check 'Cancel'" do
    fill_in "Description", with: ""
    click_button "Cancel"
    page.should have_content("Update cancelled.")
  end
  scenario "check 'Revert' - retry on error, maybe ok", js: true do
    page.execute_script("; $(document).ready; focus_select('#part_desc');")
    first("#revert")[:disabled].should == "true"
    fill_in("part_desc", with: "changed content")
    page.execute_script("$('#part_serial').focus()")
    first("#revert")[:disabled].should == nil
    click_button('revert')
    page.has_content?(HP6);
    first("#revert")[:disabled].should == "true"
  end    
end

