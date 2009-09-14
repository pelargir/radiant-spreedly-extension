class SubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by registered subscribers.
  }
  
  def process(request, response)
    if request.cookies["subscriber"].blank?
      not_a_subscriber(request, response)
    else
      super
    end
  end
  
  def not_a_subscriber(request, response)
    notice = "The page you requested is for subscribers only. Please login or register."
    response.headers["Status"] = "302"
    response.headers["Location"] = "/subscriber/login?notice=#{notice}&requested_url=#{request.url}"
  end
  
  def cache?
    false
  end
end
