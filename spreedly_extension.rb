# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SpreedlyExtension < Radiant::Extension
  version "1.0"
  description "Adds support for paid subscriptions through Spreedly."
  url "http://dev.radiantcms.org/radiant/browser/trunk/extensions/spreedly"
  
  define_routes do |map|
    map.with_options(:controller => "admin/subscriber") do |s|
      s.subscriber_index       "admin/subscriber",             :action => "index"
      s.subscriber_new         "admin/subscriber/new",         :action => "new"
      s.subscriber_edit        "admin/subscriber/edit/:id",    :action => "edit"
      s.subscriber_remove      "admin/subscriber/remove/:id",  :action => "remove"
    end
    map.with_options(:controller => "admin/spreedly") do |s|
      s.spreedly_index         "admin/spreedly",               :action => "index"
      s.spreedly_edit          "admin/spreedly/edit",          :action => "edit"
    end
    map.with_options(:controller => "subscriber_actions") do |s|
      s.subscriber_actions_login    "subscriber_actions/login",    :action => "login"
      s.subscriber_actions_logout   "subscriber_actions/logout",   :action => "logout"
      s.subscriber_actions_register "subscriber_actions/register", :action => "register"
      s.subscriber_actions_changed  "subscriber_actions/changed",  :action => "changed"
    end
  end
  
  def activate
    admin.tabs.add "Spreedly", "/admin/spreedly"
    admin.tabs.add "Subscribers", "/admin/subscriber"
    Page.send :include, SpreedlyTags
  end
end
