class GamesController < ApplicationController

  before_filter :require_current_user
  
  # GET /games
  # GET /games.json
  def index
    @games = current_user.games

    respond_to do |format|
      format.html do
        @game = Game.new        # for the form
        render :action => 'index'
      end
      format.json { render json: @games }
    end
  end

  # GET /games/1/edit
  def edit
    @game = current_user.games.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game].merge({ :user_id => current_user.id }))

    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Game was successfully added.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def check
    game = current_user.games.find(params[:id])
    game.refresh_status
    redirect_to games_path
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = current_user.games.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game].merge({ :user_id => current_user.id }))
        format.html { redirect_to games_path, notice: 'Game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = current_user.games.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :ok }
    end
  end
end
