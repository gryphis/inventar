require 'spec_helper'

describe PartsController do
  it "displays an error for a missing part" do
    get :show, :id => "not-here"
    response.should redirect_to(parts_path)
    message = "The part you were looking for could not be found."
    flash[:alert].should == message
  end
  
end
