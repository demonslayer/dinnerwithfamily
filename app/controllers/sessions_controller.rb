class SessionsController < ApplicationController
  def new
    @title = "Select User"
  end
  
  def create
    user = User.authenticate(params[:session][:name],
                            params[:session][:password])
    
    if user.nil?
      flash.now[:error] = "Invalid password for selected user"
      @title = "Select User"
      render "new"
    else
      sign_in user
      redirect_to user
    end
    
  end
  
  def destroy
  end

end
