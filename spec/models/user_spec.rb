require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :robot => "databot.png", :level => 3}
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
    robots = %w[otter.png, kabloobilen.gif, bobmeister.jpg]
    robots.each do |robot|
      valid_robot = User.new(@attr.merge(:robot => robot))
      valid_robot.should be_valid
    end
  end
  
  it "should reject invalid robot images" do
    robots = %w[otter.poo, ROBOT, jpg.robot]
    robots.each do |robot|
      valid_robot = User.new(@attr.merge(:robot => robot))
      valid_robot.should_not be_valid
    end
  end
  
  it "Should reject duplicate names" do
    User.create(@attr)
    user_with_duplicate_name = User.new(@attr)
    user_with_duplicate_name.should_not be_valid
  end
  
end
