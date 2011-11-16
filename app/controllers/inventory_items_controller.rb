class InventoryItemsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def new
    @title = "Store"
    @user = current_user
    @inventory_item = InventoryItem.new if signed_in?
  end

  def create

    if params[:inventory_item] == nil
      flash[:error] = "Sorry, but you didn't select anything to purchase!"
      redirect_to '/store'
      return
    end

    params[:inventory_item][:userjoules] = current_user.joules

    if params[:inventory_item][:content] == "wizardhat"
      params[:inventory_item][:price] = 100
    elsif params[:inventory_item][:content] == "tophat"
      params[:inventory_item][:price] = 200
    elsif params[:inventory_item][:content] == "cog"
      params[:inventory_item][:price] = 20
    elsif params[:inventory_item][:content] == "raygun"
      params[:inventory_item][:price] = 500
    elsif params[:inventory_item][:content] == "jetpack"
      params[:inventory_item][:price] = 750
    else
      flash[:error] = "Sorry, something went wrong! That's not an item at all!"
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