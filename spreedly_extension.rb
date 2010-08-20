# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SpreedlyExtension < Radiant::Extension
  version "1.2"
  description "Adds support for paid subscriptions through Spreedly."
  url "http://dev.radiantcms.org/radiant/browser/trunk/extensions/spreedly"
  
  def activate
    tab "Content" do
      add_item "Spreedly", "/admin/spreedly"
      add_item "Subscribers", "/admin/subscriber"
    end
    Page.send :include, SpreedlyTags
  end
end

# SDG
