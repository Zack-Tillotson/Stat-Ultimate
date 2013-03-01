class LinesController < ApplicationController
  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = Line.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/new
  # GET /lines/new.json
  def new
    @game = Game.find(params[:game_id])
    @activeline = Line.new
    @activeline.prepopulateReceived(@game)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/1/edit
  # TODO Fix this
  def edit
    @activeline = Line.find(params[:id])
    @game = @activeline.game
  end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(params[:line])
    @game = Game.find(@line.game_id)

    respond_to do |format|
      if @line.save
        format.html { redirect_to @game, notice: 'Line was successfully created.' }
        format.json { render json: @game, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lines/1
  # PUT /lines/1.json
  def update
    @line = Line.find(params[:id])
    @game = Game.find(@line.game_id)

    respond_to do |format|
      if @line.update_attributes(params[:line])
        format.html { redirect_to @game, notice: 'Line was successfully updated.' }
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
      format.json { head :no_content }
    end
  end
end
