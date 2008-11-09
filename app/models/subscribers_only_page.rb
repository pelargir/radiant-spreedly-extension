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
      super
    end
  end
  
  def cache?
    false
  end
end