require 'spec_helper'

describe Input do
  before(:each) do
    @attr = {
      :content => 3,
      :user_id => 1
    }
  end
  
  it "should create a new instance given valid attributes" do
    Input.create(@attr)
  end
  
end
