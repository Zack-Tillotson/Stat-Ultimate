# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # Clean out the non js form
  $('#received-label').click(->
    if $('#line_received')[0].checked
      $(this).html("Received")
    else
      $(this).html("Pulled")
  )
  $('#line_received').addClass("hide")

$ ->

  window.App = new Backbone.Marionette.Application()

  # Create the player list in backbone
  App.Player = Backbone.Model.extend(
  )

  App.PlayerList = Backbone.Collection.extend(
    model: App.Player
  )

  App.PlayerView = Backbone.Marionette.ItemView.extend(

    template: "#player-view"

    events: {
      "click .name", "toggleOnField"
    }

    toggleOnField: ->
      console.log "Toggle on field!"

  )

  App.PlayerListView = Backbone.Marionette.CollectionView.extend(
    itemView: App.PlayerView
  )

  game_id = (location.href.split('/'))[4]

  players = new App.PlayerList()
  players.url = "/games/#{game_id}/players.json"
  players.fetch(async: false)

  playerListView = new App.PlayerListView(collection: players, model: App.Player)
  playerListView.render()
  $('.player-box').html(playerListView.el)

