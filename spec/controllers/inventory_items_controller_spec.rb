require 'spec_helper'

describe InventoryItemsController do
  
  render_views
  
  describe "access control" do
    
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(selectuser_path)
    end
    
    it "should deny access to 'destory'" do
      delete :destroy, :id => 1
      response.should redirect_to(selectuser_path)
    end
    
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Store")
    end

  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :content => "tophat" , :price => 200, :userjoules => @user.joules }
      end
      
      it "should not create a new inventory item" do
        lambda do
          post :create, :inventory_item => @attr
        end.should_not change(InventoryItem, :count)
      end
      
      it "should render the store page" do
        post :create, :inventory_item => @attr
        response.should redirect_to(store_path)
      end
      
      it "should print a helpful error message" do
        post :create, :inventory_item => @attr
        flash[:error].should =~ /enough Joules/i
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = { :content => "wizardhat", :price => "100", :userjoules => @user.joules }
      end
      
      it "should create a new inventory item" do
        lambda do
          post :create, :inventory_item => @attr
        end.should change(InventoryItem, :count)
      end
      
      it "should redirect to the user's profile page" do
        post :create, :inventory_item => @attr
        response.should redirect_to(@user)
      end
      
      it "should have a flash message" do
        post :create, :inventory_item => @attr
        flash[:success].should =~ /added to your inventory/i
      end
      
      it "should deduct the number of joules" do
        post :create, :inventory_item => @attr
        @user.joules.should == 0
      end
      
    end

  end
  
  
end