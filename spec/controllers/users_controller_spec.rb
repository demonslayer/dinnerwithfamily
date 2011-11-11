require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'show'" do

    before (:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Create User")
    end

  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :robot => "", :password => "", :password_confirmation => ""}
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Create User")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Kaiya" , :robot => "databot.png", :password => "foo", :password_confirmation => "foo" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to Dinner with Family/i
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

    end

  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit User")
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      before(:each) do
        @attr = { :name => "", :robot => "", :password => "", :password_confirmation => ""}
      end

      it "should render the edit page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit User")
      end
    end


    describe "success" do

      before(:each) do
        @attr = { :name => "New Name", :robot => "tankbot", :password => "bar", :password_confirmation => "bar"}
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.robot.should == @attr[:robot]
      end

      it "should redirect to the uer show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /Updated/
      end

    end

  end
  
  describe "authentication of edit/update pages" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "for non-signed-in users" do
      
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(selectuser_path)
      end
      
      it "should deny access to 'update'" do
        put :update, :id => @user
        response.should redirect_to(selectuser_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        wrong_user = Factory(:user, :name => "Bobinator")
        test_sign_in(wrong_user)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
      
    end
    
  end
  
  describe "GET 'input'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :input, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :input, :id => @user
      response.should have_selector("title", :content => "Input Vegetables")
    end
    
  end

end
