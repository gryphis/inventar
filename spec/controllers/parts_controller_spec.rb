require 'spec_helper'

describe PartsController do
  it "displays a specific error for an unknown part" do
    get :show, id: "not-here"
    message = "The part you were looking for could not be found."
    flash[:alert].should == message
  end
  
  describe 'GET #index' do
    it "populates an array of parts" do
      part = create(:part)
      get :index
      assigns(:parts).should eq [part]
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested part to @part" do
      part = create(:part)
      get :show, id: part
      assigns(:part).should eq part
    end
    it "renders the :show template" do
      part = create(:part)
      get :show, id: part
      response.should render_template :show
    end
    it "displays an error and a part list on request of an unknown part" do
      get :show, id: "not-here"
      response.should redirect_to(parts_path)
      flash[:alert].should_not == nil
      flash[:alert].should_not == ""
    end
  end

describe 'GET #new' do
    it "assigns a new part to @part" do
      get :new
      assigns(:part).should be_a_new(Part)
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested part to @part" do
      part = create(:part)
      get :edit, id: part
      assigns(:part).should eq part
    end
    it "renders the :edit template" do
      part = create(:part)
      get :edit, id: part
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new part in the database" do
        expect{
          post :create, part: attributes_for(:part)
        }.to change(Part, :count).by(1)
      end
      it "redirects to show the part" do
        post :create, part: attributes_for(:part)
        response.should redirect_to(part_path(assigns(:part)))
      end
    end
    context "with invalid attributes" do
      it "does not save the new part in the database" do
        expect{
          post :create,
          part: attributes_for(:invalid_part_desc)
        }.to_not change(Part, :count)
      end
      it "re-renders the :new template" do
        post :create,
        part: attributes_for(:invalid_part_desc)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @part = create(:part)
    end
    it "locates the requested @part" do
      put :update, id: @part, part: attributes_for(:part)
      assigns(:part).should eq(@part)
    end
    context "valid attributes" do
      it "changes @part's attributes" do
        DATEV_ID = 654321
        put(:update, id: @part,
            part: attributes_for(:part, datev_id: DATEV_ID))
        @part.reload
        @part.datev_id.should eq(DATEV_ID)
      end
      it "redirects to the updated part" do
        put :update, id: @part, part: attributes_for(:part)
        response.should redirect_to @part
      end
    end
    context "invalid attributes" do
      it "does not change @part's attributes" do
        new_serial = @part.serial.next
        put(:update, id: @part,
            part: attributes_for(:invalid_part_desc, serial: new_serial))
        @part.reload
        @part.serial.should_not eq(new_serial)
      end
      it "re-renders the edit method" do
        put :update, id: @part, part: attributes_for(:invalid_part_desc)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @part = create(:part)
    end
    it "deletes the part" do
      expect {
        delete :destroy, id: @part
      }.to change(Part,:count).by(-1)
    end
    it "redirects to parts#index" do
      delete :destroy, id: @part
      response.should redirect_to parts_url
    end
  end
end
