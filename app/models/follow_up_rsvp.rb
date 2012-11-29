class FollowUpRsvp
  include ActiveModel::Serialization
  attr_accessor :attending, :user_id, :user_name, :lat, :lng, :image_url, :attend_msg

  def initialize(attending, user_id, user_name, lat, lng, image_url)
    @attending = attending
    @user_id = user_id
    @user_name = user_name
    @lat = lat
    @lng = lng
    @image_url = image_url
    @attend_msg = attending ? "Count me in!" : "Can't make it"
  end

  def will_attend?
    attending
  end
end