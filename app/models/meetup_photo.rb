class MeetupPhoto < MeetupResource
  extend MeetupQueryable::ByGroup

  def self.for_event(event_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :event_id => event_id } )
  end

  def self.for_member(member_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :member_id => member_id } )
  end

  def self.for_id(id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :photo_id => id } )
  end

end