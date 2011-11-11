class UsersController < ApplicationController
  def new
    @title = "Create User"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.level = 1
      @user.totalbattles = 0
      @user.totalvictories = 0
      @user.joules = 0
      @user.save
      sign_in @user
      flash[:success] = "Welcome to Dinner with Family!"
      redirect_to @user
    else
      @title = "Create User"
      render 'new'
    end
  end

end
