class MeetupEvent < MeetupResource
  extend MeetupQueryable::ByGroup
  # Example:
  #  events = MeetupGroup.for_member('437658')
  def self.for_member(member_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :member_id => member_id } )
  end

  def self.for_id(id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :event_id => id } )
  end

  def event_reference_id
    # taken from the event_url attribute
    #"event_url": "http://meetup.appsterdam.rs/events/77148392/",
    event_url.match(/\d+/)
  end

end