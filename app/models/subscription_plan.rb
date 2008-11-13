class SubscriptionPlan < ActiveResource::Base
  self.site = "https://9d8d9521282877834841cb0ae33d41e88e1cfe25:X@spreedly.com/api/v3/test" # TODO
  
  def self.to_dropdown
    find(:all).collect { |e| [e.name, e.id] }
  end
  
  def self.find_by_id(id)
    find(:all).detect { |e| e.id == id.to_i }
  end
end