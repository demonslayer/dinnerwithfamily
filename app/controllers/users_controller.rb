class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def new
    @title = "Create User"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @inventory_items = @user.inventory_items
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.level = 1
      @user.health = 3
      @user.maxhealth = 3
      @user.totalbattles = 0
      @user.totalvictories = 0
      @user.joules = 0
      @user.vegetables = 0
      @user.vegetablesthislevel = 0
      @user.save
      sign_in @user
      flash[:success] = "Welcome to Robo-Dinner-Battles!"
      redirect_to @user
    else
      @title = "Create User"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    flashmessage = "User data updated!"
    
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      
      if (params[:user][:vegetables] != nil)
        numJoules = @user.vegetables * 10
        flashmessage = flashmessage + " You have earned " + numJoules.to_s + " joules!"
        @user.joules += numJoules
        @user.vegetablesthislevel += @user.vegetables
      end
      
      if (@user.vegetablesthislevel >= 20) 
        flashmessage = flashmessage + " Congratulations! Your robot has gained a level!"
        @user.level += 1
        @user.health += 2
        @user.maxhealth += 2
        @user.vegetablesthislevel -= 20
      end
      
      @user.save
      flash[:success] = flashmessage
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def input
    @user = User.find(params[:id])
    @title = "Input Vegetables"
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
