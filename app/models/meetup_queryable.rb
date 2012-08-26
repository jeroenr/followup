module MeetupQueryable
  module ByGroup

    def for_group(group_id, api_key = nil)
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

  module ByMember
    def for_member(member_id, api_key = nil)
      @api_key = api_key

      find_everything( :params => { :member_id => member_id } )
    end
  end

  module ByEvent
    def self.for_event(event_id, api_key = nil)
      @api_key = api_key

      find_everything( :params => { :event_id => event_id } )
    end

  end
  module ByTopic
    def self.for_topic(topic, api_key = nil)
      @api_key = api_key

      find(:first, :params => { :topic => topic } )
    end

  end
end