class SessionsController < ApplicationController
  def new
    self.current_user = nil
  end

  def create
    self.current_user = User.lookup(params[:username], params[:password])
    if current_user
      redirect_to '/'
    else
      flash[:error] = 'Bad username or password'
      render :action => 'new'
    end
  end

  def destroy
    self.current_user = nil
    redirect_to '/'
  end
end
