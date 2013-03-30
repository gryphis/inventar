require 'spec_helper'

describe Part do
  it "has a valid factory" do
    create(:part).should be_valid
  end
  it "requires a description" do
    build(:invalid_desc).should_not be_valid
  end
  it "has a valid price" do
    create(:part, price: 123.45).should be_valid
    create(:part, price: 0     ).should be_valid
    create(:part, price: 1.23E9).should be_valid
  end
  it "doesn't allow an invalid price" do
    expect {
      create(:invalid_price)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
  it "ensures different datev_id values" do
    create(:part, datev_id: 123456).should     be_valid
    build( :part, datev_id: 123456).should_not be_valid
    # same check using expect/create:
    expect { create(:part, datev_id: 123456) }.to raise_error(ActiveRecord::RecordInvalid)
  end    
end
