require 'spec_helper'

feature "Viewing parts" do
  scenario "checks for 'parts' link" do
    visit root_url
    click_link "Parts"
    page.current_url.should == parts_url;
  end
  scenario "list all parts" do
    part1 = create(:part, desc: "HP DL160G6", serial: "123456",
                   price: 345.12, datev_id: 987654)
    part2 = create(:part, desc: "HP DL160G7", serial: "123457",
                   price: 345.12, datev_id: 987655)
    visit root_url
    click_link 'HP DL160G6'
    page.current_url.should == part_url(part1)
    visit root_url
    click_link 'HP DL160G7'
    page.current_url.should == part_url(part2)
  end
end
