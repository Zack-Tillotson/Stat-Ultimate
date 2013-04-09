# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # Clean out the non js form
  $('.player-box').html("")
  $('#received-label').click(->
    if $('#line_received')[0].checked
      $(this).html("Received")
    else
      $(this).html("Pulled")
  )
  $('#line_received').addClass("hide")

$ ->

  # Create the player list in backbone
  Player = Backbone.Model.extend(

  )

  PlayerList = Backbone.Collection.extend(
    model: Player
  )

  PlayerView = Backbone.View.extend(

    tagName: "div"

    events: {
      "click .name", "toggleOnField"
    }

    render: ->
      console.log "PlayerView render"
      @$el(@template(@model.getJSON()))

    template: ->
      _.template("TEST")

    toggleOnField: ->
      console.log "Toggle on field!"

  )

  PlayerListView = Backbone.Marionette.CompositeView.extend(

    tagName: "div"
    el: $('.player-box')

    initialize: (options) ->
      console.log "PlayerListView init"
      @players = new PlayerList()
      @players.url = "/games/#{options.game_id}/players.json"
      @players.fetch()

  )

  game_id = 10
  console.log "Starting app!", game_id
  playerListView = new PlayerListView(game_id: game_id).render()
  playerListView.render()
