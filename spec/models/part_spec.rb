require 'spec_helper'

describe Part do
  it "has a valid factory" do
    create(:part).should be_valid
  end
  it "is invalid without a description" do
    build(:invalid_desc).should_not be_valid
  end
  it "has a valid price" do
    create(:part, price: 123.45).should be_valid
    create(:part, price: 0).should be_valid
  end
  it "has an invalid price" do
    begin
      create(:invalid_price).should_not be_valid
    rescue ActiveRecord::RecordInvalid => invalid
      true # this is an expected exception (may superflous in future)
    end
  end
  it "has an invalid price 2" do
    begin
      expect(create(:invalid_price)).to_not be_valid
    rescue ActiveRecord::RecordInvalid => invalid
      true # this is an expected exception (may superflous in future)
    end
  end
end
