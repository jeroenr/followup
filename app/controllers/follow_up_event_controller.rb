class FollowUpEventController < ApplicationController
  
  def index
    @events = MeetupEvent.for_group_name('appsterdam')
  end

  def show
    @event = MeetupEvent.for_id(params[:id])
  end
end
