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
      @user.equippeditem = ""
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
        vegetable = params[:user][:vegtype]
        if vegetable == "spinach"
          numJoules = @user.vegetables * 13
        elsif vegetable == "broccoli"
          numJoules = @user.vegetables * 12
        elsif vegetable == "cauliflower"
          numJoules = @user.vegetables * 11
        elsif vegetable == "peppers"
          numJoules = @user.vegetables * 10
        elsif vegetable == "tomatoes"
          numJoules = @user.vegetables * 9
        elsif vegetable == "greenbeans"
          numJoules = @user.vegetables * 8
        elsif vegetable == "mushrooms"
          numJoules = @user.vegetables * 7
        elsif vegetable == "carrots" 
          numJoules = @user.vegetables * 6
        elsif vegetable == "cucumber"
          numJoules = @user.vegetables * 5
        elsif vegetable == "eggplant"
          numJoules = @user.vegetables * 4
        end
        
        flashmessage = flashmessage + " You have earned " + numJoules.to_s + " joules!"
        flashmessage = flashmessage + " Please continue to eat your " + params[:user][:vegtype] + "!"
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
  
  def equip
    @user = User.find(params[:id])
    @item = params[:item]
    
    if @item != "cog"
      @user.equippeditem = @item
      if @item == ""
        @item = "no item"
      end
      flashmessage = "#{@item} is now equipped!"
    else
      if @user.health == @user.maxhealth
        flashmessage = "You've got full health, you don't need to use that now!"
      else
        if @user.maxhealth - @user.health <= 3
          @user.health = @user.maxhealth
          flashmessage = "Recovered all your health! The cog was all used up!"
        else
          @user.health = @user.health + 3
          flashmessage = "Recovered 3 health! The cog was all used up!"
        end
        for i in @user.inventory_items
          if i.content == "cog"
            @user.inventory_items.delete(i)
          end
        end
      end
    end
      
    
    # getting rid of the password bug
    @user.password = ""
    @user.password_confirmation = ""
    
    @user.save
    
    flash[:success] = flashmessage
    redirect_to @user
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
