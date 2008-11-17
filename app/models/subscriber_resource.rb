class SubscriberResource < ActiveResource::Base
  self.element_name = "subscriber"
  
  def self.refresh
    token = Radiant::Config['spreedly.api_token']
    mode = Radiant::Config['spreedly.mode'].downcase
    self.site = "https://#{token}:X@spreedly.com/api/v3/#{mode}"
  end
  refresh
end