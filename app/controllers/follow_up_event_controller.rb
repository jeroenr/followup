class FollowUpEventController < ApplicationController
  
  def index
    @event_group = 'Appsterdam'
    @events = MeetupEvent.for_group_name(@event_group.downcase)
  end

  def show
    @event = MeetupEvent.for_id(params[:id])[0]
  end
end
