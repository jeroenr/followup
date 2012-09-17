require 'eventmachine'
require 'faye/websocket'
require 'websocket_rails/event'
require 'json'
require 'date'

class MeetupStreamReader

  def self.runner
    url = "http://stream.meetup.com/2/rsvps"
    rsvp_yes_count = 0
    rsvp_no_count = 0

    EventMachine.run do
      http = EventMachine::HttpRequest.new(url).get
      ws = Faye::WebSocket::Client.new('ws://localhost:3000/websocket')

      buffer = ""
      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r?\n/)
          hash = JSON.parse(line)
          attending = hash['response'] == 'yes'
          ws.send '["rsvp.new", {"data": {"attending" : '+"#{attending}"+'}}]'
        end
      end

      #on network failure, it calls this... but then the stream stops
      http.callback {
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
      http.errback {
        puts http.response_header.status
        puts http.response_header
        puts http.response
      }
    end
  end
end