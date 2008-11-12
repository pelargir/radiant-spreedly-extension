class SubscriberActionsController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token
  
  def login
    if subscriber = Subscriber.authenticate(params[:email], params[:password])
      login_as subscriber
      redirect_to "/subscriber"
    else
      flash[:notice] = "Unable to login."
      redirect_to "/subscriber/login"
    end
  end
  
  def logout
    if logged_in?
      cookies["subscriber"] = nil
      flash[:notice] = "You have been logged out."
    end
    redirect_to "/subscriber/login"
  end
  
  def register
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save
      login_as @subscriber
      redirect_to "/subscriber"
    else
      flash[:notice] = "One or more validation errors occured."
      redirect_to "/subscriber/register"
    end
  end
  
  def changed
    if params[:return]
      flash[:notice] = "Your account has been refreshed."
      redirect_to "/subscriber"
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
end
