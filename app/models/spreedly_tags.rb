module SpreedlyTags
  include Radiant::Taggable
  include ActionController::UrlWriter  
  default_url_options[:host] = "localhost:3000"

  tag "subscribers" do |tag|
    tag.expand
  end

  tag "subscribers:each" do |tag|
    result = []
    Subscriber.find(:all, :order => "email ASC").each do |s|
      tag.locals.subscriber = s
      result << tag.expand
    end
    result
  end

  tag "subscribers:each:subscriber" do |tag|
    s = tag.locals.subscriber
    %{<b>#{s.email}</b>}
  end
  
  tag "subscriber" do |tag|
    tag.expand
  end
  
  tag "subscriber:logout" do |tag|
    "<a href=\"#{subscriber_logout_url}\">Logout</a>"
  end
  
  tag "subscriber:username" do |tag|
    id = tag.locals.page.request.cookies["subscriber"]
    Subscriber.find(id).email unless id.empty?
  end
end
