require 'spec_helper'

feature "Viewing parts" do
  scenario "Listing all parts" do
    part = Factory.create(:part, :desc => "HP DL160G6")
    visit '/'
    click_link 'HP DL160G6'
    page.current_url.should == part_url(part)
  end
end