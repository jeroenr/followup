require 'eventmachine'
require 'json'
require 'date'

class MeetupStreamReader

  def self.runner
    url = "http://stream.meetup.com/2/rsvps"
    rsvp_yes_count = 0
    rsvp_no_count = 0

    EventMachine.run do
      http = EventMachine::HttpRequest.new(url).get

      buffer = ""
      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r?\n/)
          hash = JSON.parse(line)
          #puts FollowUpRsvp.new(hash['response'] == 'yes')
          if hash['response'] == 'yes'
            rsvp_yes_count += 1
          else
            rsvp_no_count += 1
          end
          rsvp_update = {
            :yes => rsvp_yes_count,
            :no => rsvp_no_count
          }
          puts "New rsvp update #{rsvp_update}"
          WebsocketRails[:rsvp].trigger 'new', rsvp_update
          #broadcast_message :new_rsvp, rsvp_update
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