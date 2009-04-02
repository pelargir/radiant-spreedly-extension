module SpreedlyTags
  include Radiant::Taggable
  
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  
  def self.included(klass)
    super
    def klass.default_url_options
      {:host => "localhost:3000"}
    end
  end
  
  tag "flash" do |tag|
    tag.expand
  end
  
  tag "flash:notices" do |tag|
    content_tag(:div, nil, :id => "notice", :style => "font-weight:bold; color:red") <<
    javascript_include_tag("spreedly")
  end
  
  ## subscriber
  
  tag "subscriber" do |tag|
    id = tag.locals.page.request.cookies["subscriber"]
    tag.locals.subscriber = Subscriber.find(id) unless id.empty?
    tag.expand
  end
  
  tag "subscriber:logout" do |tag|
    link_to "Logout", subscriber_actions_logout_url
  end
  
  tag "subscriber:username" do |tag|
    tag.locals.subscriber.email
  end
  
  tag "subscriber:refresh" do |tag|
    s = tag.locals.subscriber
    link_to tag.attr["title"] || "Refresh Subscription Status",
      "/subscriber_actions/changed?subscriber_ids=#{s.id}&return=true"
  end
  
  tag "subscriber:subscription" do |tag|
    s = tag.locals.subscriber
    if s.active?
      "You are all paid up!"
    elsif s.spreedly_configured?
      "No active subscription. #{link_to 'Subscribe', s.spreedly_url}"
    else
      content_tag(:span, "Spreedly is not configured properly. " <<
        "Please contact an admin.", :style => "font-weight:bold; color:red")
    end
  end
  
  ## login
  
  tag "subscriber:login" do |tag|
    tag.expand
  end
  
  tag "subscriber:login:form" do |tag|
    requested_url = tag.locals.page.request.parameters["requested_url"]
    "<form action=\"#{subscriber_actions_login_url}\" method=\"post\">" <<
    "<input type=\"hidden\" name=\"requested_url\" value=\"#{requested_url}\" />" <<
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
    link_to tag.attr["title"] || "Register", "/subscriber/register"
  end
  
  tag "subscriber:register:form" do |tag|
    "<form action=\"/subscriber_actions/register\" method=\"post\">" <<
      "Email: <input type=\"text\" name=\"subscriber[email]\" size=\"20\" /><br/>" <<
      "Password: <input type=\"password\" name=\"subscriber[password]\" size=\"20\" /><br/>" <<
      "<input type=\"submit\" name=\"submit\" value=\"Register\" />" <<
    "</form>"
  end
end
