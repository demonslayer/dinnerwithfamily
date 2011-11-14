require 'spec_helper'

describe InventoryItem do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "wizardhat"}
  end
  
  it "should create a new instance given valid attributes" do
    InventoryItem.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @inventory_item = @user.inventory_items.create(@attr)
    end
    
    it "should have a user attribute" do
      @inventory_item.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @inventory_item.user_id.should == @user.id
      @inventory_item.user.should == @user
    end
    
  end
  
end
