# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SpreedlyExtension < Radiant::Extension
  version "1.0"
  description "Adds support for paid subscriptions through Spreedly."
  url "http://dev.radiantcms.org/radiant/browser/trunk/extensions/spreedly"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/subscribers') do |subscriber|
      subscriber.link_index           'admin/subscribers',             :action => 'index'
      subscriber.link_new             'admin/subscribers/new',         :action => 'new'
      subscriber.link_edit            'admin/subscribers/edit/:id',    :action => 'edit'
      subscriber.link_remove          'admin/subscribers/remove/:id',  :action => 'remove'
    end
  end
  
  def activate
    admin.tabs.add "Subscribers", "/admin/subscribers", :before => "Layouts"
  end
  
  def deactivate
    # admin.tabs.remove "Spreedly"
  end
  
end