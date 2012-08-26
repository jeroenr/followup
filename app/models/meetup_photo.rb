class MeetupPhoto < MeetupResource
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByMember
  extend MeetupQueryable::ByEvent


  def self.for_id(id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :photo_id => id } )
  end

end