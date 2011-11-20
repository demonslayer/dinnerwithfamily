class BattlesController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    @battle = current_user.battles.build(params[:battle])
    
    if @battle.save
      flash[:success] = "#{ @battle.receiver.name } was challenged to battle!"
      redirect_to current_user
    else
      flash[:error] = "Please choose a user to challenge!"
      redirect_to "/battle"
    end
    
  end
  
  def destroy
  end
  
  def new
    @title = "Battle"
    @user = current_user
    @battle = Battle.new if signed_in?
  end
  
end