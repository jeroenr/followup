class MeetupMember < MeetupResource
  extend MeetupQueryable::ByGroup
  extend MeetupQueryable::ByMember

  def self.for_topic(topic, api_key = nil)
    @api_key = api_key

    find(:first, :params => { :topic => topic } )
  end

  def self.for_service(service, api_key = nil)
    @api_key = api_key

    find(:first, :params => { :service => service } )
  end

end
