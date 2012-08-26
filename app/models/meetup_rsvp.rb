class MeetupRsvp < MeetupResource
  extend MeetupQueryable::ByEvent

  def will_attend?
    response == "yes"
  end

end
