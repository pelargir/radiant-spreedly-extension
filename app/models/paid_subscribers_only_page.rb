class PaidSubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by registered subscribers
    who have made a payment through Spreedly.
  }
  
  def process(request, response)
    if request.cookies["subscriber"].empty?
      response.headers["Status"] = "302"
      notice = "The page you requested is for subscribers only. Please login or register."
      response.headers["Location"] = "/subscriber/login?notice=#{notice}"
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
