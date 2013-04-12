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
    initialize: (options) ->
      @set('active', false)
  )

  App.PlayerList = Backbone.Collection.extend(
    model: App.Player

    initialize: (options) ->
      @url = options.url if options

    syncWithActivePlayers: ->
      _.each App.players.toArray(), (p) ->
        if !_.isEmpty(_.filter App.activePlayers.toArray(), (ap) -> ap.get('player_id') is p.get('id'))
          p.set('active', true)

  )

  App.PlayerView = Backbone.Marionette.ItemView.extend(

    template: "#player-view"

    className: ->
      if @model.get('active')
        "player color2"
      else
        "player color1"

    events: {
      "click": "toggleOnField"
    }

    toggleOnField: (e) ->
      t = $(e.target)
      if t.is("div") then t = t.find("label")
      if(t.attr("active") is "true")
        t.parent().removeClass("color2")
        t.parent().addClass("color1")
        t.attr("active", "false")
        App.vent.trigger('player:toggle', @model)
      else if App.activePlayers.length < 7
        t.parent().removeClass("color1")
        t.parent().addClass("color2")
        t.attr("active", "true")
        App.vent.trigger('player:toggle', @model)

  )

  App.PlayerListView = Backbone.Marionette.CollectionView.extend(
    itemView: App.PlayerView
    el: $('.player-box')
  )

  # Active player list
  App.ActivePlayer = App.Player.extend(
    initialize: (options) ->
      @set('throwaway', 0)
      @set('drop', 0)
      @set('takeaway', 0)
      @set('player_id', options.player_id ? @get('id'))
  )

  App.ActivePlayerList = Backbone.Collection.extend(
    model: App.ActivePlayer
    initialize: (options) ->
      @url = options.url if options
    syncWithPlayers: ->
      _.each App.activePlayers.toArray(), (p) ->
        player = _.findWhere(App.players.toArray(), {id: p.get('player_id')})
        p.set('name', player.get('name'))

  )
  App.ActivePlayerView = Backbone.Marionette.ItemView.extend(
    template: "#active-player-view"
    className: "active-player"
    tagName: "tr"
  )

  App.ActivePlayerListView = Backbone.Marionette.CompositeView.extend(
    template: "#active-players"
    itemView: App.ActivePlayerView
    className: "active"
    itemViewContainer: "tbody"
    el: $('#on-field-box')

    initialize: (options) ->
      App.vent.on('player:toggle', @toggleActive)

    toggleActive: (p) =>
      item = _.filter(App.activePlayers.toArray(), (ap) -> ap.get('player_id') is p.get('id'))
      console.log "Active player toggle!", p.get('id'), item
      if _.isEmpty(item)
        App.activePlayers.push new App.ActivePlayer(p.toJSON())
      else
        App.activePlayers.remove item
  )

  # Start it up!
  App.players = new App.PlayerList(url: "/games/#{App.game_id}/players.json")
  App.activePlayers = new App.ActivePlayerList(url: "/games/#{App.game_id}/activeplayers.json")

  syncPlayers = _.after(2, =>
    App.players.syncWithActivePlayers()
    App.activePlayers.syncWithPlayers()
    App.activePlayers.trigger('reset')
    App.players.trigger('reset')
  )
  App.players.on('sync', syncPlayers)
  App.activePlayers.on('sync', syncPlayers)

  App.players.fetch()
  App.activePlayers.fetch()

  playerListView = new App.PlayerListView(collection: App.players, model: App.Player)
  playerListView.render()

  activePlayersView = new App.ActivePlayerListView(collection: App.activePlayers)
  activePlayersView.render()

