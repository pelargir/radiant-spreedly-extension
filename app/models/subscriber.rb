class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def spreedly_url
    "https://spreedly.com/radiant-test/subscribers/672/subscribe/145/#{email}-#{id}"
  end
  
  def refresh_from_spreedly
    update_attributes!(:active => SubscriberResource.find(id).active)
  end
end
