class SubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by subscribers who have
    made a payment through Spreedly.
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
        response.headers["Status"] = "302"
        response.headers["Location"] = "/subscriber/show"
      end
    end
  end
  
  def cache?
    false
  end
end