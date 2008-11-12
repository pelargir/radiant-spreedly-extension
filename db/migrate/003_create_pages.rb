class CreatePages < ActiveRecord::Migration
  def self.up
    #<SubscribersOnlyPage id: 10, title: "Subscriber", slug: "subscriber", breadcrumb: "Subscriber", class_name: "SubscribersOnlyPage", status_id: 100, parent_id: 1, layout_id: nil, created_at: "2008-11-12 14:39:39", updated_at: "2008-11-12 17:55:54", published_at: "2008-11-12 09:39:39", created_by_id: 1, updated_by_id: 1, virtual: false, lock_version: 10, description: "", keywords: "">
    #<Page id: 11, title: "Login", slug: "login", breadcrumb: "Login", class_name: "Page", status_id: 100, parent_id: 10, layout_id: nil, created_at: "2008-11-12 14:40:13", updated_at: "2008-11-12 14:57:14", published_at: "2008-11-12 09:40:13", created_by_id: 1, updated_by_id: 1, virtual: false, lock_version: 3, description: "", keywords: "">
    #<Page id: 12, title: "Register", slug: "register", breadcrumb: "Register", class_name: "Page", status_id: 100, parent_id: 10, layout_id: nil, created_at: "2008-11-12 17:56:24", updated_at: "2008-11-12 18:11:35", published_at: "2008-11-12 12:56:24", created_by_id: 1, updated_by_id: 1, virtual: false, lock_version: 4, description: "", keywords: "">
  end

  def self.down
  end
end
