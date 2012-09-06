class MeetupEvent < MeetupResource
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByMember

  def self.for_id(id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :event_id => id } )
  end

  def self.for_venue(venue_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :venue_id => venue_id } )
  end

  def event_reference_id
    # taken from the event_url attribute
    #"event_url": "http://meetup.appsterdam.rs/events/77148392/",
    event_url.match(/[0-9a-z]*\/$/)[0].chop
  end

end