require 'digest/sha1'

class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :password, :if => :password_required?
  validates_uniqueness_of :email
  
  attr_accessor :password
  before_save :encrypt_password
  
  def spreedly_url
    "https://spreedly.com/radiant-test/subscribers/672/subscribe/145/#{email}-#{id}"
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
