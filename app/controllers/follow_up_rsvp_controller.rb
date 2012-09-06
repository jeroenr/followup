class FollowUpRsvpController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    @rsvp_yes_count = 0
    @rsvp_no_count = 0
  end

  def rsvp
    rsvp = FollowUpRsvp.new message
    register_rsvp(rsvp)
  end
  
  private

  def register_rsvp(rsvp)
    if rsvp.will_attend?
      @rsvp_yes_count += 1
    else
      @rsvp_no_count += 1
    end

    rsvp_update = {
        :rsvp_yes => @rsvp_yes_count,
        :rsvp_no => @rsvp_no_count
    }
    WebsocketRails[:rsvp].trigger 'new', rsvp_update
  end
end