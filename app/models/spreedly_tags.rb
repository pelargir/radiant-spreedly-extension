module SpreedlyTags
  include Radiant::Taggable
  include ActionController::UrlWriter  
  default_url_options[:host] = "localhost:3000"
  
  ## subscribers
  
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
  
  ## subscriber
  
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
  
  ## login
  
  tag "subscriber:login" do |tag|
    tag.expand
  end
  
  tag "subscriber:login:form" do |tag|
    "<form action=\"#{subscriber_actions_login_url}\" method=\"post\">" <<
    "Email: <input type=\"text\" name=\"email\" size=\"20\" /><br/>" <<
    "Password: <input type=\"password\" name=\"password\" size=\"20\" /><br/>" <<
    "<input type=\"submit\" name=\"submit\" value=\"Login\" />" <<
    "</form>"
  end
  
  ## register
  
  tag "subscriber:register" do |tag|
    tag.expand
  end
  
  tag "subscriber:register:link" do |tag|
    "<a href=\"#{subscriber_register_url}\">#{tag.attr['title'] || 'Register'}</a>"
  end
end
