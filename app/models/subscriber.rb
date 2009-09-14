require 'digest/sha1'

class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :password, :if => :password_required?
  validates_uniqueness_of :email
  
  attr_accessor :password
  before_save :encrypt_password
  
  def spreedly_url
    if spreedly_configured?
      site_name = Radiant::Config['spreedly.site_name']
      plan_id = Radiant::Config['spreedly.plan_id']
      "https://spreedly.com/#{site_name}/subscribers/#{id}/subscribe/#{plan_id}/#{email}-#{id}"
    end
  end
  
  def spreedly_account_url
    site_name = Radiant::Config['spreedly.site_name']
    "https://spreedly.com/#{site_name}/subscribers/#{id}"
  end
  
  def spreedly_configured?
    !Radiant::Config['spreedly.api_token'].blank? &&
    !Radiant::Config['spreedly.site_name'].blank? &&
    !Radiant::Config['spreedly.plan_id'].blank?
  end
  
  def status
    active? ? "Paid" : "Unpaid"
  end
  
  def refresh_from_spreedly
    update_attributes!(:active => SubscriberResource.find(id).active)
  end
  
  def self.authenticate(email, password)
    s = find_by_email(email)
    s && s.authenticated?(password) ? s : nil
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password)
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
  
  private
  
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
end
