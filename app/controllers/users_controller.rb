class UsersController < ApplicationController
  def new
    @title = "Create User"
  end
  
  def show
    @user = User.find(params[:id])
  end

end
