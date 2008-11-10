class SubscriberController < ApplicationController
  no_login_required
  helper_method :logged_in?, :current_subscriber
  skip_before_filter :verify_authenticity_token, :only => :changed
  
  def login
    if request.post?
      if subscriber = Subscriber.authenticate(params[:email], params[:password])
        cookies["subscriber"] = { :value => subscriber.id.to_s, :expires => 1.hour.from_now }
      else
        flash[:notice] = "Unable to login."
      end
      redirect_to subscriber_login_url
    else
      render :layout => false
    end
  end
  
  def logout
    cookies["subscriber"] = nil
    flash[:notice] = "You have been logged out."
    redirect_to subscriber_login_url
  end
  
  def register
    if request.post?
      @subscriber = Subscriber.new(params[:subscriber])
      if @subscriber.save
        flash[:notice] = "You've been registered. Please login."
        redirect_to subscriber_login_url
      else
        render :layout => false
      end
    else
      render :layout => false
    end
  end
  
  def changed
    ids = (params[:subscriber_ids] || "").split(",")
    subscribers = Subscriber.find(:all, :conditions => ["id in (?)", ids])
    subscribers.each { |s| s.refresh_from_spreedly }
    head :ok
  end
  
  def done
    render :layout => false
  end
  
  private
  
  def logged_in?
    @current_subscriber ||= cookies["subscriber"].blank? ? nil : Subscriber.find_by_id(cookies["subscriber"])
  end
  
  def current_subscriber
    @current_subscriber if logged_in?
  end
end
