class CreatePages < ActiveRecord::Migration
  def self.up
    home_page = Page.find(:first, :conditions => {:parent_id => nil})
    
    subscriber_page = SubscribersOnlyPage.new do |p|
      p.title = "Subscriber"
      p.slug = "subscriber"
      p.breadcrumb = "Subscriber"
      p.class_name = "SubscribersOnlyPage"
      p.status_id = 100
      p.parent = home_page
      p.published_at = Time.now
    end
    subscriber_page.save!
    
    PagePart.new do |p|
      p.name = "body"
      p.filter_id = "Textile"
      p.content = "<r:flash:notices />\r\n\r\n*Username:* <r:subscriber:username />\r\n\r\n*Subscription:* <r:subscriber:subscription />\r\n\r\n<r:subscriber:refresh />\r\n\r\n<r:subscriber:logout />\r\n"
      p.page = subscriber_page
    end.save!
    
    login_page = Page.new do |p|
      p.title = "Login"
      p.slug = "login"
      p.breadcrumb = "Login"
      p.class_name = "Page"
      p.status_id = 100
      p.parent = subscriber_page
      p.published_at = Time.now
    end
    login_page.save!
    
    PagePart.new do |p|
      p.name = "body"
      p.filter_id = "Textile"
      p.content = "<r:flash:notices />\r\n\r\n<r:subscriber:login:form />\r\n\r\n<r:subscriber:register:link />"
      p.page = login_page
    end.save!
    
    register_page = Page.new do |p|
      p.title = "Register"
      p.slug = "register"
      p.breadcrumb = "Register"
      p.class_name = "Page"
      p.status_id = 100
      p.parent = subscriber_page
      p.published_at = Time.now
    end
    register_page.save!
    
    PagePart.new do |p|
      p.name = "body"
      p.filter_id = "Textile"
      p.content = "<r:flash:notices />\r\n\r\n<r:subscriber:register:form />\r\n\r\n\"Go back\":/subscriber/login"
      p.page = register_page
    end.save!
  end

  def self.down
    SubscribersOnlyPage.find_by_title("Subscriber").destroy
  end
end
