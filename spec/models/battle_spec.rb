require 'spec_helper'

describe Battle do
  before(:each) do
    @user1 = User.create(:name => "user1", :level => 3, :robot => "databot",
    :password => "foo", :password_confirmation => "foo")
    @user2 = User.create(:name => "user2", :level => 4, :robot => "tankbot",
    :password => "bar", :password_confirmation => "bar")
    @attr = {:receiver_id => 2}
  end
  
  it "should create a new instance given valid attributes" do
    Battle.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @battle = @user1.battles.create(@attr)
    end
    
    it "should respond to sender attribute" do
      @battle.should respond_to(:sender)
    end
    
    it "should respond to receiver attribute" do
      @battle.should respond_to(:receiver)
    end
    
    it "should have the right associated users" do
      @battle.sender_id.should == @user1.id
      @battle.sender.should == @user1
      @battle.receiver.should == @user2
    end
  end
  
end
