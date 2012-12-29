require 'spec_helper'

feature 'Creating Parts' do
  before do
    visit '/'
    click_link 'New Part'
  end
  scenario "can create a part" do
    fill_in 'Description', :with => 'HP DL160G6'
    fill_in 'Serial',      :with => '123456'
    fill_in 'Price',       :with =>  1234.56
    fill_in 'DatevID',     :with => '456456'
    click_button 'Create Part'
    page.should have_content('Part has been created.')
    part = Part.find_by_desc('HP DL160G6')
    page.current_url.should == part_url(part)
    title = "Inventar.Part"
    find("title").should have_content(title)
  end
  scenario "can not create a part without a description" do
    click_button 'Create Part'
    page.should have_content("Part has not been created.")
    page.should have_content("Desc can't be blank")
  end

end