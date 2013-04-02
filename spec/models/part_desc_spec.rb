require 'spec_helper'

describe PartDesc do
  it "has a valid factory" do
    create(:part_desc).should be_valid
  end
  it "requires a description" do
    build(:part_desc, desc: nil).should_not be_valid
    build(:part_desc, desc: "").should_not be_valid
  end
  it "requires a manufacturer" do
    build(:part_desc, manufac: nil).should_not be_valid
    build(:part_desc, manufac: "").should_not be_valid
  end
  it "requires a parttype" do
    build(:part_desc, parttype: "").should_not be_valid
    build(:part_desc, parttype: nil).should_not be_valid
  end
end
