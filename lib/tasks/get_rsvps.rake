require 'meetup_stream_reader'

namespace :meetup do
  desc "get rsvps"
  task(:get_rsvps => :environment) do
    MeetupStreamReader.runner
  end
end