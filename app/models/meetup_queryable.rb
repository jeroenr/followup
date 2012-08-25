module MeetupQueryable
  module ByGroup

    def self.for_group(group_id, api_key = nil)
      @api_key = api_key

      find_everything(:params => { :group_id => group_id })
    end

    def for_groups(group_ids, api_key = nil)
      for_group(group_ids.join ",", api_key)
    end

    def for_group_name(group_name, api_key = nil)
      @api_key = api_key

      find_everything( :params => { :group_urlname => group_name } )
    end
  end
end