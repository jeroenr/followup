class FollowUpRsvp
  include ActiveModel::Serialization
  attr_accessor :attending, :user_id

  def initialize(attending, user_id)
    @attending = attending
    @user_id = user_id
  end

  def will_attend?
    attending
  end
end