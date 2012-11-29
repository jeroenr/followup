class FollowUpRsvpController < WebsocketRails::BaseController
  def initialize_session
  end

  def rsvp
    rsvp = FollowUpRsvp.new(message[:attending], message[:user_id], message[:user_name], message[:lat], message[:lng], message[:image_url])
    register_rsvp(rsvp)
  end
  
  private

  def register_rsvp(rsvp)
    WebsocketRails[:rsvp].trigger 'new', rsvp
  end
end