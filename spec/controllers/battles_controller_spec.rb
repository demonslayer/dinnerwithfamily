require 'spec_helper'

describe BattlesController do
  
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
      response.should have_selector("title", :content => "Battle")
    end

  end
  
  describe "POST 'create'" do

     before(:each) do
       @user1 = test_sign_in(Factory(:user))
       @user2 = User.create(:name => "Mr. Opponent", :robot => "tankbot", :password => "foo", :password => "foo")
     end

     describe "failure" do
       before(:each) do
         @attr = { }
       end

       it "should not create a new battle instance" do
         lambda do
           post :create, :battle => @attr
         end.should_not change(Battle, :count)
       end

       it "should render the battle request page" do
         post :create, :battle => @attr
         response.should redirect_to("/battle")
       end

       it "should print a helpful error message" do
         post :create, :battle => @attr
         flash[:error].should =~ /choose a user to challenge/i
       end

     end

     describe "success" do
       before(:each) do
         @attr = { :receiver_id => @user2.id }
       end

       it "should create a new battle instance" do
         lambda do
           post :create, :battle => @attr
         end.should change(Battle, :count)
       end

       it "should redirect to the user's profile page" do
         post :create, :battle => @attr
         response.should redirect_to(@user1)
       end

       it "should have a flash message" do
         post :create, :battle => @attr
         flash[:success].should =~ /was challenged to battle/i
       end

     end

   end
  
end

