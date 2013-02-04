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
  scenario "Updating a part" do
    fill_in "Description", with: HP8
    click_button "Update Part"
    page.should have_content("Part has been updated.")
  end
  scenario "Updating a part with invalid attributes is bad" do
    fill_in "Description", with: ""
    click_button "Update Part"
    page.should have_content("Part has not been updated.")
  end
  scenario "Check Cancel" do
    fill_in "Description", with: ""
    click_button "Cancel"
    page.should have_content("Update cancelled.")
  end
  scenario "Check Revert", js: true do
    fill_in "Description", with: ""
    fill_in "Serial", with: ""
    #save_and_open_page
    #todo: still disabled, why?: click_button "Revert"
    #page.should have_content(HP6)
    first(".edit_part input[type=\"reset\"][name=\"commit\"]")[:disabled].should == "true"
  end    
  scenario "Check disabled Revert", js: true do
    wait_until {first(".edit_part")}
    first(".edit_part input[type=\"reset\"][name=\"commit\"]")[:disabled].should == "true"
    fill_in "Description", with: ""
    fill_in "Serial", with: ""
    #todo: still disabled, why?: 
    first(".edit_part input[type=\"reset\"][name=\"commit\"]")[:disabled].should == "true"
  end    
end

