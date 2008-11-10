class Subscriber < ActiveRecord::Base
  def spreedly_url
    "https://spreedly.com/radiant-test/subscribers/672/subscribe/145/#{email}"
  end
end
