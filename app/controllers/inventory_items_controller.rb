class InventoryItemsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  
  def new
    @title = "Store"
    @user = current_user
    @inventory_item = InventoryItem.new if signed_in?
  end
  
  def create
    
    params[:inventory_item][:userjoules] = current_user.joules
    
    if params[:inventory_item][:content] == "wizardhat"
      params[:inventory_item][:price] = 100
    elsif params[:inventory_item][:content] == "tophat"
      params[:inventory_item][:price] = 200
    else
      flash[:error] = "Sorry, something went wrong!"
      redirect_to '/store'
      return
    end
    
        
    @inventory_item = current_user.inventory_items.build(params[:inventory_item])
        
    if @inventory_item.save
      current_user.joules = current_user.joules - @inventory_item.price
      
      # this prevents automatic over-writing of the password
      current_user.password = ""
      current_user.password_confirmation = ""
      
      current_user.save
      flash[:success] = "#{ @inventory_item.content } was added to your inventory!"
      redirect_to current_user
    else
      flash[:error] = "Sorry, you don't have enough Joules to buy #{ params[:inventory_item][:content] }!"
      redirect_to '/store'
      return
    end
       
  end
  
  def destroy
  end
  
end