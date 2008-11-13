class SubscriberActionsController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token
  
  def login
    if subscriber = Subscriber.authenticate(params[:email], params[:password])
      login_as subscriber
      if params[:requested_url].blank?
        redirect_to "/subscriber"
      else
        redirect_to params[:requested_url]
      end
    else
      redirect_with "/subscriber/login", :notice => "Unable to login.", :requested_url => params[:requested_url]
    end
  end
  
  def logout
    cookies["subscriber"] = nil
    redirect_with "/subscriber/login", :notice => "You have been logged out."
  end
  
  def register
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save
      login_as @subscriber
      redirect_to "/subscriber"
    else
      redirect_with "/subscriber/register", :notice => "One or more values are missing."
    end
  end
  
  def changed
    if params[:return]
      redirect_with "/subscriber", :notice => "Your subscription status has been refreshed."
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
  
  def redirect_with(url, params)
    url_params = params.collect { |k,v| "#{k}=#{v}" }.join("&")
    redirect_to url_params.blank? ? url : "#{url}?#{url_params}"
  end
end
