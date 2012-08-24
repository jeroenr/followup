// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require websocket_rails/main

var dispatcher = new WebSocketRails('localhost:3000/websocket');

dispatcher.on_open = function(data) {
    console.log('Connection has been established: ' + data);
}

dispatcher.on_close = function(data) {
    console.log('Connection has been closed: ' + data);
}

$(function() {
    $('#rsvp_yes').click(function(message) {
        dispatcher.trigger('rsvp.yes');
    });

    $('#rsvp_no').click(function(message) {
        dispatcher.trigger('rsvp.no');
    });

//    var channel = dispatcher.subscribe('rsvp');
//    channel.bind('new', function(rsvp) {
//      console.log('a new post about '+rsvp.attending+' arrived!');
//    });

    dispatcher.bind('new_rsvp', function(rsvp_update) {
      console.log('New RSVP. Total is now: ' + rsvp_update);
        $('#rsvp_yes_count').html(rsvp_update.rsvp_yes);
        $('#rsvp_no_count').html(rsvp_update.rsvp_no);
    });
});

