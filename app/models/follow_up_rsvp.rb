class FollowUpRsvp
  include ActiveModel::Serialization
  attr_accessor :attending, :event

  def initialize(attending, event_id)
    @attending = attending
    @event = event_id
  end

  def will_attend?
    attending
  end
end