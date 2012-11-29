require 'eventmachine'
require 'faye/websocket'
require 'websocket_rails/event'
require 'json'
require 'date'

class MeetupStreamReader

  def self.runner

    rsvp_event_buffer = SynchronizedRingBuffer.new(50)
    rsvp_queue = Queue.new

    count = 0


    EventMachine.run do
      meetup_ws_endpoint = Faye::WebSocket::Client.new('ws://stream.meetup.com/2/rsvps')
      lastminute_app_ws_endpoint = Faye::WebSocket::Client.new('ws://localhost:3000/websocket')

      lastminute_generator = Timer.new(3) do
          rsvp_event = rsvp_queue.pop(true) rescue rsvp_event_buffer.sample
          lastminute_app_ws_endpoint.send rsvp_event.serialize
      end

      lastminute_generator.start

      meetup_ws_endpoint.onmessage = lambda do |event|
        hash = JSON.parse(event)
        new_rsvp_event = WebsocketRails::Event.new "rsvp.new", :data => {
              :name => hash['member']['member_name'],
              :attending => hash['response'] == 'yes',
              :lat => hash['venue']['lat'],
              :lng => hash['venue']['lon']
          }
        rsvp_event_buffer << new_rsvp_event
        rsvp_queue << new_rsvp_event
        count += 1
      end

      meetup_ws_endpoint.onerror = lambda do |event|
        puts "Something went wrong: #{event}"
      end

      meetup_ws_endpoint.onclose = lambda do |event|
        puts "Connection closed: #{event}"
      end
    end
  end
end