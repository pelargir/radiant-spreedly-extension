class PaidSubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by registered subscribers
    who have made a payment through Spreedly.
  }
  
  def process(request, response)
    if request.cookies["subscriber"].empty?
      response.headers["Status"] = "302"
      response.headers["Location"] = "/subscriber/login"
    else
      s = Subscriber.find(request.cookies["subscriber"])
      if s && s.active?
        super
      else
        # TODO need msg explaining that only paid subscribers can access this page
        response.headers["Status"] = "302"
        response.headers["Location"] = "/subscriber/login"
      end
    end
  end
  
  def cache?
    false
  end
end
