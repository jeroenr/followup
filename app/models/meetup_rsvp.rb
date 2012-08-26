class MeetupRsvp < MeetupResource
  extend MeetupQueryable::ByEvent

  def member_id
    # taken from the link attribute
    #"link"=>"http://www.meetup.com/members/6410758"
    link.match(/\d+$/)[0]
  end

end
