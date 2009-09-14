class SubscriberResource < ActiveResource::Base
  self.element_name = "subscriber"
  
  def self.refresh
    token = Radiant::Config['spreedly.api_token']
    site_name = Radiant::Config['spreedly.site_name']
    self.site = "https://#{token}:X@spreedly.com/api/v4/#{site_name}"
  end
  refresh
end