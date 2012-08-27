class MeetupGroup < MeetupResource
  extend MeetupQueryable::ByMember
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByTopic

  def self.for_organizer(organizer_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :organizer_id => organizer_id } )
  end


  def self.for_category(category_id, api_key = nil)
    @api_key = api_key

    find_everything( :params => { :category_id => category_id } )
  end

  def can_join?
    join_mode != "closed"
  end
  
end
