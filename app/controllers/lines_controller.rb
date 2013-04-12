class LinesController < ApplicationController
  
  # POST /lines.json
  def create

    @line = parseLine(params[:line])
    
    #@line = Line.new(params[:line])
    @game = Game.find(@line.game_id)

    respond_to do |format|
      if @line.save
        format.html { redirect_to @game, notice: 'Line was successfully created.' }
        format.mobile { redirect_to @game, notice: 'Line was successfully created.' }
        format.json { render json: @game, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.mobile { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def parseLine(p)
    ret = Line.new()

    ret.game_id = p["game_id"]
    ret.received = p["received"]
    ret.scored = p["scored"]

    if p["line_players"]
      p["line_players"].each do |lp|
        retLp = LinePlayer.new()
        id = lp[0]
        retLp.player_id = id
        retLp.drop = lp[1]["drop"]
        retLp.throwaway = lp[1]["throwaway"]
        retLp.takeaway = lp[1]["takeaway"]
        ret.line_players << retLp
      end
    end

    ret
  end

  # PUT /lines/1
  # PUT /lines/1.json
  def update
    @line = Line.find(params[:id])
    @game = Game.find(@line.game_id)

    respond_to do |format|
      if @line.update_attributes(params[:line])
        format.html { redirect_to @game, notice: 'Line was successfully updated.' }
        format.mobile { redirect_to @game, notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line = Line.find(params[:id])
    @game = Game.find(@line.game_id)
    @line.destroy

    respond_to do |format|
      format.html { redirect_to game_url(@game) }
      format.mobile { redirect_to game_url(@game) }
      format.json { head :no_content }
    end
  end
end
