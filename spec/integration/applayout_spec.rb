require 'spec_helper'

feature "check application layout" do
  before do
    visit root_url
  end
  scenario "'financial.com AG' link" do
    click_link "financial.com AG"
    page.current_url.should == "http://financial.com/"
  end
  scenario "inventar-home link" do
    click_link "Inventar"
    page.current_url.should == root_url
  end
end
