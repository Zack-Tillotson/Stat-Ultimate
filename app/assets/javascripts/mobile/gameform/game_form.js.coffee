# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.player-box').html("")
  $('#received-label').click(->
    if $('#line_received')[0].checked
      $(this).html("Received")
    else
      $(this).html("Pulled")
  )
  $('#line_received').addClass("hide")

$ ->

  window.App = new Backbone.Marionette.Application({game_id: (location.href.split('/'))[4]})

  # Full player list
  App.Player = Backbone.Model.extend(
  )

  App.PlayerList = Backbone.Collection.extend(
    model: App.Player
  )

  App.PlayerView = Backbone.Marionette.ItemView.extend(

    template: "#player-view"
    className: ->
      ret = ["player"]
      ret

    events: {
      "click label.name": "toggleOnField"
    }

    toggleOnField: (e) ->
      App.vent.trigger('player:toggle', @model)

  )

  App.PlayerListView = Backbone.Marionette.CollectionView.extend(
    itemView: App.PlayerView
    el: $('.player-box')
  )

  # Active player list
  App.ActivePlayerView = Backbone.Marionette.ItemView.extend(
    template: "#active-player-view"
  )

  App.ActivePlayerListView = Backbone.Marionette.CollectionView.extend(
    template: "#active-players"
    itemView: App.ActivePlayerView
    el: $('#on-field-box')

    initialize: (options) ->
      App.vent.on('player:toggle', @toggleActive)

    toggleActive: (p) =>
      App.activePlayers.push p
  )

  # Start it up!
  App.activePlayers = new App.PlayerList()

  activePlayersView = new App.ActivePlayerListView(collection: App.activePlayers, model: App.Player)
  activePlayersView.render()

  App.players = new App.PlayerList()
  App.players.url = "/games/#{App.game_id}/players.json"
  App.players.fetch(async: false)

  playerListView = new App.PlayerListView(collection: App.players, model: App.Player)
  playerListView.render()
