class FollowUpRsvp
  include ActiveModel::Serialization
  attr_accessor :attending, :user_id, :user_name, :lat, :lng

  def initialize(attending, user_id, user_name, lat, lng)
    @attending = attending
    @user_id = user_id
    @user_name = user_name
    @lat = lat
    @lng = lng
  end

  def will_attend?
    attending
  end
end