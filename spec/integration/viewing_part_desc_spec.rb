require 'spec_helper'

feature "Viewing part descriptions" do
  scenario "link to view part descriptions list" do
    visit root_url
    click_link "Part Descriptions"
    page.current_url.should == part_descs_url;
  end
  scenario "list all part descriptions" do
    part1 = create(:part_desc, desc: "HP DL160G6", manufac: "HP",
                   parttype: "server", partno: "345.12987654")
    part2 = create(:part_desc, desc: "HP DL160G7", manufac: "HP",
                   parttype: "server", partno: "346.12553321")
    visit part_descs_url
    click_link 'HP DL160G6'
    page.current_url.should == part_desc_url(part1)
    visit part_descs_url
    click_link 'HP DL160G7'
    page.current_url.should == part_desc_url(part2)
  end
end
