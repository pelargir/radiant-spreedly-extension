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
      s.subscriber_register    "subscriber/register",          :action => "register"
      s.subscriber_changed     "subscriber/changed",           :action => "changed"
      s.subscriber_show        "subscriber/show",              :action => "show"
    end
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
  end
  
  def activate
    admin.tabs.add "Spreedly", "/admin/spreedly"
    admin.tabs.add "Subscribers", "/admin/subscriber"
    Page.send :include, SpreedlyTags
  end
end
