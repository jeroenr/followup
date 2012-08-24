class FollowUpRsvp < ActiveModel
  attr_accessor :attending

  def initialize(attending)
    @attending = attending
  end

  def will_attend?
    attending
  end
end