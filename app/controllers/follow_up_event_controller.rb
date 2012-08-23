class FollowUpEventController < ApplicationController
  def index
    @events = MeetupEvent.for_group_name('appsterdam')
  end
end
