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
    fill_in 'Type',        with: 'Server'
    fill_in 'PartNo',      with: part_no
    click_button 'Create PartDesc'
    page.should have_content('PartDesc has been created.')
    part = PartDesc.find_by_desc('HP DL160G6')
    page.current_url.should == part_url(partdesc)
    page.should (have_content(desctxt) and have_content(part_no))
    title = "Inventar.PartDesc"
    #save_and_open_page
    first("title").native.text.should have_content(title)
  end
  scenario "don't create a part description without a description" do
    click_button 'Create PartDesc'
    page.should have_content("Part has not been created.")
    page.should have_content("Description can't be blank")
  end
  scenario "clear a partially filled create form using 'Revert' - retry on error, maybe ok", js: true do
    page.execute_script("; $(document).ready; focus_select('#partdesc_desc');")
    find_field("partdesc_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
    fill_in("partdesc_desc", with: "changed content")
    page.execute_script("$('#partdesc_partno').focus()")
    find_field("partdesc_desc").value.should == "changed content"
    first("#revert")[:disabled].should == nil
    click_button('revert')
    find_field("partdesc_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
  end    
  scenario "cancel a create" do
    click_button 'Cancel'
    page.should have_content("Creation cancelled.")
    page.current_url.should == partdescs_url
  end
end
