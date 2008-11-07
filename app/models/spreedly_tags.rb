module SpreedlyTags
  include Radiant::Taggable

  tag "subscriptions" do |tag|
    tag.expand
  end

  tag "subscriptions:each" do |tag|
    result = []
    Subscriber.find(:all, :order => "email ASC").each do |s|
      tag.locals.subscription = s
      result << tag.expand
    end
    result
  end

  tag "subscriptions:each:subscription" do |tag|
    s = tag.locals.subscription
    %{<b>#{s.email}</b>}
  end
end