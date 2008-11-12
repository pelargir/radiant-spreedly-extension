class SubscriberActionsController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token
  
  def login
    if subscriber = Subscriber.authenticate(params[:email], params[:password])
      login_as subscriber
      redirect_to "/subscriber"
    else
      redirect_with_notice "/subscriber/login", "Unable to login."
    end
  end
  
  def logout
    cookies["subscriber"] = nil
    redirect_with_notice "/subscriber/login", "You have been logged out."
  end
  
  def register
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save
      login_as @subscriber
      redirect_to "/subscriber"
    else
      redirect_with_notice "/subscriber/register", "One or more values are missing."
    end
  end
  
  def changed
    if params[:return]
      redirect_with_notice "/subscriber", "Your subscription status has been refreshed."
    else
      ids = (params[:subscriber_ids] || "").split(",")
      subscribers = Subscriber.find(:all, :conditions => ["id in (?)", ids])
      subscribers.each { |s| s.refresh_from_spreedly }
      head :ok
    end
  end
  
  private
  
  def logged_in?
    cookies["subscriber"].blank? ? nil : Subscriber.find_by_id(cookies["subscriber"])
  end
  
  def login_as(subscriber)
    cookies["subscriber"] = { :value => subscriber.id.to_s, :expires => 1.hour.from_now }
  end
  
  def redirect_with_notice(url, notice)
    redirect_to "#{url}?notice=#{notice}"
  end
end
