# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SpreedlyExtension < Radiant::Extension
  version "1.0"
  description "Adds support for paid subscriptions through Spreedly."
  url "http://dev.radiantcms.org/radiant/browser/trunk/extensions/spreedly"
  
  define_routes do |map|
    map.with_options(:controller => "subscriber") do |s|
      s.subscriber_login       "subscriber/login",             :action => "login"
      s.subscriber_logout      "subscriber/logout",            :action => "logout"
    end
    map.with_options(:controller => "admin/subscriber") do |s|
      s.subscriber_index       "admin/subscriber",             :action => "index"
      s.subscriber_new         "admin/subscriber/new",         :action => "new"
      s.subscriber_edit        "admin/subscriber/edit/:id",    :action => "edit"
      s.subscriber_remove      "admin/subscriber/remove/:id",  :action => "remove"
    end
  end
  
  def activate
    admin.tabs.add "Subscribers", "/admin/subscriber", :before => "Layouts"
    Page.send :include, SpreedlyTags
  end
end