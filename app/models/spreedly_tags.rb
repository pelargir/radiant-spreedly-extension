module SpreedlyTags
  include Radiant::Taggable
  include ActionController::UrlWriter
  default_url_options[:host] = "localhost:3000"
  
  tag "flash" do |tag|
    tag.expand
  end
  
  tag "flash:notices" do |tag|
    "<div id=\"notice\" style=\"font-weight:bold; color:red\"></div>" <<
    "<script src=\"/javascripts/spreedly.js\" type=\"text/javascript\"></script>"
  end
  
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
    id = tag.locals.page.request.cookies["subscriber"]
    tag.locals.subscriber = Subscriber.find(id) unless id.empty?
    tag.expand
  end
  
  tag "subscriber:logout" do |tag|
    "<a href=\"#{subscriber_actions_logout_url}\">Logout</a>"
  end
  
  tag "subscriber:username" do |tag|
    tag.locals.subscriber.email
  end
  
  tag "subscriber:refresh" do |tag|
    s = tag.locals.subscriber
    "<a href=\"/subscriber_actions/changed?subscriber_ids=#{s.id}&" <<
      "return=true\">#{tag.attr['title'] || 'Refresh Subscription Status'}</a>"
  end
  
  tag "subscriber:subscription" do |tag|
    s = tag.locals.subscriber
    if s.active?
      "You are all paid up!"
    elsif SpreedlyConfig.first
      "No active subscription. <a href=\"#{s.spreedly_url}\">Subscribe</a>"
    else
      "<span style=\"font-weight:bold; color:red\">" <<
      "Spreedly is not configured properly. Please contact an admin." <<
      "</span>"
    end
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
    "<a href=\"/subscriber/register\">#{tag.attr['title'] || 'Register'}</a>"
  end
  
  tag "subscriber:register:form" do |tag|
    "<form action=\"/subscriber_actions/register\" method=\"post\">" <<
      "Email: <input type=\"text\" name=\"subscriber[email]\" size=\"20\" /><br/>" <<
      "Password: <input type=\"password\" name=\"subscriber[password]\" size=\"20\" /><br/>" <<
      "<input type=\"submit\" name=\"submit\" value=\"Register\" />" <<
    "</form>"
  end
end
