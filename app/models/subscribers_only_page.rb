class SubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by registered subscribers.
  }
  
  def process(request, response)
    if request.cookies["subscriber"].empty?
      response.headers["Status"] = "302"
      notice = "The page you requested is for subscribers only. Please login or register."
      response.headers["Location"] = "/subscriber/login?notice=#{notice}"
    else
      super
    end
  end
  
  def cache?
    false
  end
end
