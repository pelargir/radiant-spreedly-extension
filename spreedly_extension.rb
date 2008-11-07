# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SpreedlyExtension < Radiant::Extension
  version "1.0"
  description "Adds support for paid subscriptions through Spreedly."
  url "http://dev.radiantcms.org/radiant/browser/trunk/extensions/spreedly"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/subscriber') do |subscriber|
      subscriber.subscriber_index       'admin/subscriber',             :action => 'index'
      subscriber.subscriber_new         'admin/subscriber/new',         :action => 'new'
      subscriber.subscriber_edit        'admin/subscriber/edit/:id',    :action => 'edit'
      subscriber.subscriber_remove      'admin/subscriber/remove/:id',  :action => 'remove'
    end
  end
  
  def activate
    admin.tabs.add "Subscribers", "/admin/subscriber", :before => "Layouts"
    Page.send :include, SpreedlyTags
  end
end