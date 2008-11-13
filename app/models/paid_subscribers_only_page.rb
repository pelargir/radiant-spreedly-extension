class PaidSubscribersOnlyPage < SubscribersOnlyPage

  description %{
    Protected page that can only be accessed by registered subscribers
    who have made a payment through Spreedly.
  }
  
  def process(request, response)
    if request.cookies["subscriber"].empty?
      not_a_subscriber(request, response)
    else
      s = Subscriber.find(request.cookies["subscriber"])
      if s && s.active?
        super
      else
        response.headers["Status"] = "302"
        notice = "The page you requested is for paid subscribers only. Please subscribe."
        response.headers["Location"] = "/subscriber?notice=#{notice}"
      end
    end
  end
  
  def cache?
    false
  end
end
