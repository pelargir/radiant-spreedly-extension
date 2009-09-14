class SubscriptionPlan < ActiveResource::Base
  def self.refresh
    token = Radiant::Config['spreedly.api_token']
    site_name = Radiant::Config['spreedly.site_name']
    self.site = "https://#{token}:X@spreedly.com/api/v4/#{site_name}"
  end
  refresh
  
  def self.to_dropdown
    find(:all).collect { |e| [e.name, e.id] }
  end
  
  def self.find_by_id(id)
    find(:all).detect { |e| e.id == id.to_i }
  end
end