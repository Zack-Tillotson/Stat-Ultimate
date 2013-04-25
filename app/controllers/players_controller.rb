class PlayersController < ApplicationController

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])
    @team = @player.team

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  def pointgraph
    @player = Player.find(params[:id])
    @container = params[:container] || "container"
    @title = params[:title] || "Points"
    @subtitle = params[:subtitle] || ""

    @data = Hash.new
    @player.team.games.each { |g|
      @data[g.id] = Hash.new
      @data[g.id]['won'] = @player.points_played({:game_id => g.id, :scored => true})
      @data[g.id]['lost'] = @player.points_played({:game_id => g.id, :scored => false})
    }

    respond_to do |format|
      format.json { render 'graph/pointsgraph' }
    end
  end
  
  def errorgraph
    @player = Player.includes(:line_players => [:line => [:game]]).find(params[:id])
    @container = params[:container] || "container"
    @title = params[:title] || ""
    @subtitle = params[:subtitle] || ""

    @data = Hash.new
    @player.line_players.each { |lp, i|
      puts "Lp #{lp}, line_id #{lp.line_id}"
      puts "line #{lp.line}"
      if @data[lp.line.game.id] == nil
        @data[lp.line.game.id] = Hash.new
        @data[lp.line.game.id]['drop'] = 0
        @data[lp.line.game.id]['throwaway'] = 0
      end
      @data[lp.line.game.id]['drop'] += lp.drop
      @data[lp.line.game.id]['throwaway'] += lp.throwaway
    }

    respond_to do |format|
      format.json { render 'graph/errorsgraph' }
    end
  end
end
