require 'spec_helper'

describe PartDescsController do
  it "displays a specific error for an unknown part description" do
    get :show, id: "not-here"
    message = "The part description you were looking for could not be found."
    flash[:alert].should == message
  end
  
  describe 'GET #index' do
    it "populates an array of part descriptions" do
      part_desc = create(:part_desc)
      get :index
      assigns(:part_descs).should eq [part_desc]
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested part description to @part_desc" do
      part_desc = create(:part_desc)
      get :show, id: part_desc
      assigns(:part_desc).should eq part_desc
    end
    it "renders the :show template" do
      part_desc = create(:part_desc)
      get :show, id: part_desc
      response.should render_template :show
    end
    it "displays an error and a part description list on request of an unknown part description" do
      get :show, id: "not-here"
      response.should redirect_to(part_descs_path)
      flash[:alert].should_not == nil
      flash[:alert].should_not == ""
    end
  end

describe 'GET #new' do
    it "assigns a new part description to @part_desc" do
      get :new
      assigns(:part_desc).should be_a_new(PartDesc)
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested part description to @part_desc" do
      part_desc = create(:part_desc)
      get :edit, id: part_desc
      assigns(:part_desc).should eq part_desc
    end
    it "renders the :edit template" do
      part_desc = create(:part_desc)
      get :edit, id: part_desc
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new part description in the database" do
        expect{
          post :create, part_desc: attributes_for(:part_desc)
        }.to change(PartDesc, :count).by(1)
      end
      it "redirects to show the part description" do
        post :create, part_desc: attributes_for(:part_desc)
        response.should redirect_to(part_desc_path(assigns(:part_desc)))
      end
    end
    context "with invalid attributes" do
      it "does not save the new part description in the database" do
        expect{
          post :create,
          part_desc: attributes_for(:part_desc, desc: nil)
        }.to_not change(PartDesc, :count)
      end
      it "re-renders the :new template" do
        post :create,
        part_desc: attributes_for(:part_desc, desc: nil)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @part_desc = create(:part_desc)
    end
    it "locates the requested @part_desc" do
      put :update, id: @part_desc, part_desc: attributes_for(:part_desc)
      assigns(:part_desc).should eq(@part_desc)
    end
    context "valid attributes" do
      it "changes @part_desc's attributes" do
        new_parttype = @part_desc.parttype.next
        put(:update, id: @part_desc,
            part_desc: attributes_for(:part_desc, parttype: new_parttype))
        @part_desc.reload
        @part_desc.parttype.should eq(new_parttype)
      end
      it "redirects to the updated part description" do
        put :update, id: @part_desc, part_desc: attributes_for(:part_desc)
        response.should redirect_to @part_desc
      end
    end
    context "invalid attributes" do
      it "does not change @part_desc's attributes" do
        new_parttype = @part_desc.parttype.next
        put(:update, id: @part_desc,
            part_desc: attributes_for(:part_desc, desc: nil, parttype: new_parttype))
        @part_desc.reload
        @part_desc.parttype.should_not eq(new_parttype)
      end
      it "re-renders the edit method" do
        put :update, id: @part_desc, part_desc: attributes_for(:part_desc, desc: nil)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @part_desc = create(:part_desc)
    end
    it "deletes the part_desc" do
      expect {
        delete :destroy, id: @part_desc
      }.to change(PartDesc,:count).by(-1)
    end
    it "redirects to part_descs#index" do
      delete :destroy, id: @part_desc
      response.should redirect_to part_descs_url
    end
  end
end
