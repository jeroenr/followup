class FollowUpRsvpController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    @rsvp_count = 0
  end

  def rsvp_yes
    @rsvp = FollowUpRsvp.new true
    register_rsvp
  end

  def rsvp_no
    @rsvp = FollowUpRsvp.new false
    register_rsvp
  end

  private

  def register_rsvp
    @rsvp_count += 1
  end
end