ActionController::Routing::Routes.draw do |map|
  map.with_options(:controller => "admin/subscriber") do |s|
    s.subscriber_index       "admin/subscriber",             :action => "index", :conditions => {:method => :get}
    s.subscriber_new         "admin/subscriber/new",         :action => "new"
    s.subscriber_create      "admin/subscriber",             :action => "create", :conditions => {:method => :post}
    s.subscriber_edit        "admin/subscriber/edit/:id",    :action => "edit"
    s.subscriber_update      "admin/subscriber/:id",         :action => "update", :conditions => {:method => :put}
    s.subscriber_remove      "admin/subscriber/remove/:id",  :action => "remove"
    s.subscriber_destroy     "admin/subscriber/:id",         :action => "destroy", :conditions => {:method => :delete}
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