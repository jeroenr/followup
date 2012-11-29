# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require MapUtil
#= require Map
#= require MathUtil

websocket_endpoint = 'localhost:3000/websocket'

$ ->
  websocket_dispatcher = new WebSocketRails(websocket_endpoint)
  websocket_dispatcher.bind 'update_viewers', (message) =>
    noty({text: message, timeout: 1000, type: 'success'})

  mapCanvas = $('#map_canvas')
  #generate optimal zoom level for Mediterranean area
  zoomLevel = MapUtil.zoom(mapCanvas, 44.4, 35.0, 32.4, -2.5 )
  map = new Map(41.0, 11.0, zoomLevel, mapCanvas)

  rsvps = []
  channel = websocket_dispatcher.subscribe 'rsvp'
  channel.bind 'new', (rsvp) =>
    marker = map.addMarker(rsvp)
    infoWindow = map.addInfoWindow(rsvp,marker)
    
    rsvps.shift()[0].setMap(null) if rsvps.length > 4
    rsvps.push([marker,infoWindow])
    rsvps.reverse()[1..].map ([_,infoWindow]) -> infoWindow.close()




