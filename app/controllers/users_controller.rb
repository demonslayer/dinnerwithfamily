class UsersController < ApplicationController
  def new
    @title = "Create User"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

end
