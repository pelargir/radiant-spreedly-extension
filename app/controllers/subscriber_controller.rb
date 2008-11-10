class SubscriberController < ApplicationController
  no_login_required
  helper_method :logged_in?, :current_subscriber
  
  def login
    if request.post?
      if subscriber = Subscriber.find_by_email(params[:email])
        cookies["subscriber"] = { :value => subscriber.id.to_s, :expires => 1.hour.from_now }
      else
        flash[:error] = "Could not find subscriber with email address #{ERB::Util.h params[:email]}"
      end
      redirect_to subscriber_login_url
    else
      render :layout => false
    end
  end
  
  def logout
    cookies["subscriber"] = nil
    flash[:error] = "You have been logged out"
    redirect_to subscriber_login_url
  end
  
  def register
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
