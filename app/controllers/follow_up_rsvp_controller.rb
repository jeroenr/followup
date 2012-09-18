class FollowUpRsvpController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    @rsvp_yes_count = 0
    @rsvp_no_count = 0
  end

  def rsvp
    rsvp = FollowUpRsvp.new message[:attending], message[:user_id]
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
        :yes => @rsvp_yes_count,
        :no => @rsvp_no_count,
        :user_id => rsvp.user_id
    }
    WebsocketRails[:rsvp].trigger 'new', rsvp_update
  end
end