class FollowUpRsvpController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    @rsvp_count = 0
  end

  def rsvp_yes
    rsvp = FollowUpRsvp.new true
    register_rsvp(rsvp)
  end

  def rsvp_no
    rsvp = FollowUpRsvp.new false
    register_rsvp(rsvp)
  end
  
  private

  def register_rsvp(rsvp)
    @rsvp_count += 1
    #send_message :create_successful, @rsvp_count, :namespace => :rsvp
    broadcast_message :new_rsvp, @rsvp_count
    #WebsocketRails[:rsvp].trigger 'new', @rsvp_count
  end
end