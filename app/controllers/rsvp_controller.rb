class RsvpController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    @rsvp_count = 0
  end
end