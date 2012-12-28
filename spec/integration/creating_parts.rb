require 'spec_helper'

feature 'Creating Parts' do
  scenario "can create a part" do
    visit '/'
    click_link 'New Part'
    fill_in 'Description', :with => 'HP DL160G6'
    fill_in 'Serial',      :with => '123456'
    fill_in 'Price',       :with =>  1234.56
    fill_in 'DatevID',     :with => '456456'
    click_button 'Create Part'
    page.should have_content('Part has been created.')
  end
end
