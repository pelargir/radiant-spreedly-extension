module SpreedlyTags
  include Radiant::Taggable

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
    "<a href=\"/subscriber/logout\">Logout</a>"
  end
end