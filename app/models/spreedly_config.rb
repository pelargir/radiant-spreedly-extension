class SpreedlyConfig < ActiveRecord::Base
  validates_presence_of :login_name, :plan_id
  validates_numericality_of :plan_id
  
  def self.first
    find(:first)
  end
end
