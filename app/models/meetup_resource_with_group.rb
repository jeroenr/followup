class MeetupResourceWithGroup < MeetupResource
  def self.for_group(group_id, api_key = nil)
    @api_key = api_key.blank? ? MEETUP_API_KEY : api_key

    find_everything(:params => { :group_id => group_id })
  end

  def self.for_groups(group_ids, api_key = nil)
    for_group(group_ids.join ",", api_key)
  end

  def self.for_group_name(group_name, api_key = nil)
    @api_key = api_key.blank? ? MEETUP_API_KEY : api_key

    find_everything( :params => { :group_urlname => group_name } )
  end
end