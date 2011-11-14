require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", 
      :robot => "databot.png", 
      :level => 3,
      :password => "booger",
      :password_confirmation => "booger"}
    end

    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end

    it "should require a name" do
      no_name_user = User.new(@attr.merge(:name => ""))
      no_name_user.should_not be_valid
    end

    it "should require a robot" do
      sad_robotless_user = User.new(@attr.merge(:robot => ""))
      sad_robotless_user.should_not be_valid
    end

    it "should reject names that are too long" do
      long_name = "a" * 51
      long_name_user = User.new(@attr.merge(:name => long_name))
      long_name_user.should_not be_valid
    end

    it "should accept valid robot images" do
      robots = %w[otterbot, kabloobilenbot, bobmeisterbot]
      robots.each do |robot|
        valid_robot = User.new(@attr.merge(:robot => robot))
        valid_robot.should be_valid
      end
    end

    it "should reject invalid robot images" do
      robots = %w[poo, otter, kabloobilen]
      robots.each do |robot|
        invalid_robot = User.new(@attr.merge(:robot => robot))
        invalid_robot.should_not be_valid
      end
    end

    it "Should reject duplicate names" do
      User.create(@attr)
      user_with_duplicate_name = User.new(@attr)
      user_with_duplicate_name.should_not be_valid
    end

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require password confirmation" do
      User.new(@attr.merge(:password => "foo", :password_confirmation => "bar")).should_not be_valid
    end

    describe "password encryption" do

      before (:each) do
        @user = User.create!(@attr)
      end

      it "should have an encrypted password attribute" do
        @user.should respond_to(:encrypted_password)
      end

      it "should set the encrypted password" do
        @user.encrypted_password.should_not be_blank
      end

      describe "has_password? method" do

        it "should be true if the passwords match" do
          @user.has_password?(@attr[:password]).should be_true
        end

        it "should be false if the passwords don't match" do
          @user.has_password?("fakepassword").should be_false
        end

      end

      describe "authenticate method" do

        it "should return nil on name/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:name], "wrong")
          wrong_password_user.should be_nil
        end

        it "should return nil for name with no user" do
          nonexistent_user = User.authenticate("Bobmeister", @attr[:password])
          nonexistent_user.should be_nil
        end

        it "should return the user on name/password match" do
          matching_user = User.authenticate(@attr[:name], @attr[:password])
          matching_user.should == @user
        end

      end

    end
    
    describe "inventory associations" do

      before(:each) do
        @user = User.create(@attr)
        @item = Factory(:inventory_item, :user => @user)
      end

      it "should have an inventory attribute" do
        @user.should respond_to(:inventory_items)
      end
      
      it "should have the right inventory" do
        @user.inventory_items.should == [@item]
      end
      
      it "should destroy associated inventory items" do
        @user.destroy
        InventoryItem.find_by_id(@item.id).should be nil
      end
      
    end
  
end
