require 'spec_helper'

feature "Application layout" do
  before do
    visit root_url
  end
  scenario "ensure 'financial.com AG' link" do
    click_link "financial.com AG"
    page.current_url.should == "http://financial.com/"
  end
  scenario "ensure 'inventar'-home link" do
    click_link "Inventar"
    page.current_url.should == root_url
  end
end
