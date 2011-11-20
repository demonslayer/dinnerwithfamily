class BattlesController < ApplicationController
    
  def create
    
    if params[:respond] == "Respond to Battle Request!" then
      id = params[:battle][:current_battle].to_i
      battle = current_user.sent_battles.find_by_id(id)
      
      # this prevents automatic over-writing of the password
      current_user.password = ""
      current_user.password_confirmation = ""
      
      if params[:battle][:accepted] == "false" then
        battle.destroy
        flash[:success] = "You have successfully escaped! However, running away cost 1 energy point."
        
        if current_user.health >= 1 then
          current_user.health -= 1
        else
          current_user.health = 0
        end
        
        current_user.save
        
        redirect_to "/battle"
      else
        opponent_id = battle.sender_id.to_i
        opponent = User.find_by_id(opponent_id)
        
        if opponent.health > current_user.health then
          current_user.health = 0
          current_user.totalbattles += 1
          flash[:error] = "Sorry, you lost the battle. Better luck next time!"
        else 
          current_user.totalbattles += 1
          current_user.totalvictories += 1
          flash[:success] = "Congratulations, you won the battle! You rock!"
        end
        
        current_user.save
        battle.destroy
        redirect_to "/battle"
        
      end
      
      return
    end
    
    receiver_id = params[:battle][:receiver_id]
    opponent = User.find_by_id(receiver_id)
    
    params[:battle][:sender] = current_user
    params[:battle][:sender_id] = current_user.id
    
    @battle = current_user.sent_battles.build(params[:battle])
        
    if @battle.save
      opponent.received_battles << @battle
      flash[:success] = "#{ @battle.receiver.name } was challenged to battle!"
      redirect_to "/battle"
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
    @battle = Battle.new
  end
  
  def edit
    @title = "Accept or Decline"
    @user = current_user
  end
  
end