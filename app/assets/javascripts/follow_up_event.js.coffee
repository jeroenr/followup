# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

websocket_endpoint = 'localhost:3000/websocket'

$ ->
    websocket_dispatcher = new WebSocketRails(websocket_endpoint)

    websocket_dispatcher.on_open = (data) ->
        console.log "Connection has been established: #{data}"

    websocket_dispatcher.on_close = (data) ->
        console.log "Connection has been closed: #{data}"
        window.websocket_dispatcher = new WebSocketRails(websocket_endpoint)

    $('#rsvp_yes').bind 'click', (message) =>
        websocket_dispatcher.trigger 'rsvp.new',true

    $('#rsvp_no').bind 'click', (message) =>
        websocket_dispatcher.trigger 'rsvp.new',false

#    channel = websocket_dispatcher.subscribe 'rsvp'
#    channel.bind 'new', (rsvp) =>
#      console.log "new rsvp #{rsvp}"

    websocket_dispatcher.bind 'new_rsvp', (rsvp_update) =>
        console.log "New RSVP. Total is now: #{rsvp_update}"
        $('#rsvp_yes_count').html rsvp_update.rsvp_yes
        $('#rsvp_no_count').html rsvp_update.rsvp_no


