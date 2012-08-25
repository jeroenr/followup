class MeetupMember < MeetupResource
  extend MeetupQueryable::ByGroup

  # Examples:
  #  member = MeetupMember.for_member('437658')
  def self.for_member(member_id, api_key = nil)
    @api_key = api_key

    find(:first, :params => { :member_id => member_id } )  
  end

end
