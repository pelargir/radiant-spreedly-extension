class SubscribersOnlyPage < Page

  description %{
    Protected page that can only be accessed by subscribers who have
    made a payment through Spreedly.
  }
  
  def process(request, response)
    super
    response.body << "<span style=\"font-weight:bold; color:red\">This is a protected page!</span>"
  end
end