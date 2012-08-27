class MeetupMember < MeetupResource
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByMember
  extend MeetupQueryable::ByTopic

  def self.for_service(service, api_key = nil)
    @api_key = api_key

    find(:first, :params => { :service => service } )
  end

end
