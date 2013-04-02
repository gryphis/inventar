require 'spec_helper'

feature 'Creating PartDescs' do
  before do
    visit '/'
    click_link 'Part Descriptions'
    click_link 'New'
  end
  scenario "create a part description" do
    desctxt = 'HP DL160G6'
    part_no = '22222'
    fill_in 'Description', with: desctxt
    fill_in 'Manufacturer',with: 'HP'
    fill_in 'PartType',    with: 'Server'
    fill_in 'PartNo',      with: part_no
    click_button 'Create PartDesc'
    page.should have_content('Part Description has been created.')
    part_desc = PartDesc.find_by_desc('HP DL160G6')
    page.current_url.should == part_desc_url(part_desc)
    page.should (have_content(desctxt) and have_content(part_no))
    title = "Inventar.PartDesc"
    #save_and_open_page
    first("title").native.text.should have_content(title)
  end
  scenario "don't create a part description without a description" do
    click_button 'Create PartDesc'
    page.should have_content("Part Description has not been created.")
    page.should have_content("Desc can't be blank")
  end
  scenario "clear a partially filled create form using 'Revert' - retry on error, maybe ok", js: true do
    page.execute_script("; $(document).ready; focus_select('#part_desc_desc');")
    find_field("part_desc_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
    fill_in("part_desc_desc", with: "changed content")
    page.execute_script("$('#part_desc_partno').focus()")
    find_field("part_desc_desc").value.should == "changed content"
    first("#revert")[:disabled].should == nil
    click_button('revert')
    find_field("part_desc_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
  end    
  scenario "cancel a create" do
    click_button 'Cancel'
    page.should have_content("Creation cancelled.")
    page.current_url.should == part_descs_url
  end
end
