class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @team = @game.team
    @lines = @game.lines
    @activeline = Line.createFromGame(@game)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  def review 
    @game = Game.includes(:lines => [:players], :team => [:players => :lines]).find(params[:id])
    @team = @game.team
    @lines = @game.lines
    @players = @team.players
    @activeline = Line.new
    @activeline.prepopulate_received(@game)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @team = Team.find(@game.team_id)
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.mobile { redirect_to @game, notice: 'Game was successfully created.' }
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def graph
    @game = Game.find(params[:id], :include => [:team, :lines])
    @container = params[:container] || "container"
    @title = params[:title] || "Points"
    @subtitle = params[:subtitle] || ""

    prevus=0
    prevthem=0
    @data = Hash.new
    @data[0] = Hash.new
    @data[0]['us'] = prevus
    @data[0]['them'] = prevthem
    @game.lines.each_with_index { |l, i|
      prevus += l.scored ? 1 : 0
      prevthem += l.scored ? 0 : 1
      @data[i+1] = Hash.new
      @data[i+1]['us'] = prevus
      @data[i+1]['them'] = prevthem
    }

    respond_to do |format|
      format.json
    end
  end
end
