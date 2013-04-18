class TeamsController < ApplicationController

  def review
    @team = Team.includes(:games => [:lines], :players => [:lines]).find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where('user_id = ?', session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.includes(:games => [:lines]).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def new
    @team = fillOutPlayers(Team.new)

    respond_to do |format|
      format.html # new.html.erb
      format.mobile # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = fillOutPlayers(Team.find(params[:id]))
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])
    @team.user_id = session[:user_id];

    respond_to do |format|
      if @team.save
        format.mobile { redirect_to @team, notice: 'Team was successfully created.' }
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.mobile { render action: "new" }
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.mobile { redirect_to @team, notice: 'Team was successfully updated.' }
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def errorsgraph
    @team = Team.includes(:games => [:lines => [:line_players]]).find(params[:id])
    @container = params[:container] || "container"
    @title = params[:title] || ""
    @subtitle = params[:subtitle] || ""

    @data = Hash.new
    if @team.games.length > 0
      @team.games.each_with_index { |g, i|
        @data[i+1] = Hash.new
        @data[i+1]['drop'] = 0
        @data[i+1]['throwaway'] = 0
        g.lines.each { |l|
          l.line_players.each { |lp|
            @data[i+1]['drop'] += lp.drop
            @data[i+1]['throwaway'] += lp.throwaway
          }
        }
      }
    end

    respond_to do |format|
      format.json { render 'graph/errorsgraph' }
    end
  end

  def fillOutPlayers(team)
    (team.players.size + 25).times do
      team.players.append(Player.new)
    end
    team
  end

end
