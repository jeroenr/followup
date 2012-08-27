class MeetupVenue < MeetupResource
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByEvent

  def self.for_id(id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :venue_id => id } )
  end

  def address
    address_1
  end

end