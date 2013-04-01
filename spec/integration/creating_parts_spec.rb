require 'spec_helper'

feature 'Creating Parts' do
  before do
    visit '/'
    click_link 'New'
  end
  scenario "create a part" do
    serial = "123456"
    fill_in 'Description', with: 'HP DL160G6'
    fill_in 'Serial',      with: serial
    fill_in 'Price',       with:  1234.56
    fill_in 'Datev_ID',    with: '456456'
    click_button 'Create Part'
    page.should have_content('Part has been created.')
    part = Part.find_by_desc('HP DL160G6')
    page.current_url.should == part_url(part)
    page.should have_content(serial)
    title = "Inventar.Part"
    #save_and_open_page
    first("title").native.text.should have_content(title)
  end
  scenario "don't create a part without a description" do
    click_button 'Create Part'
    page.should have_content("Part has not been created.")
    page.should have_content("Description can't be blank")
  end
  scenario "clear a partially filled create form using 'Revert' - retry on error, maybe ok", js: true do
    page.execute_script("; $(document).ready; focus_select('#part_desc');")
    find_field("part_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
    fill_in("part_desc", with: "changed content")
    page.execute_script("$('#part_serial').focus()")
    find_field("part_desc").value.should == "changed content"
    first("#revert")[:disabled].should == nil
    click_button('revert')
    find_field("part_desc").value.should == ""
    first("#revert")[:disabled].should == "true"
  end    
  scenario "cancel a create" do
    click_button 'Cancel'
    page.should have_content("Creation cancelled.")
    page.current_url.should == parts_url
  end
end
