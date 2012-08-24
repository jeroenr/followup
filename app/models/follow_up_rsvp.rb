class FollowUpRsvp
  include ActiveModel::Serialization
  attr_accessor :attending

  def initialize(attending)
    @attending = attending
  end

  def will_attend?
    attending
  end
end