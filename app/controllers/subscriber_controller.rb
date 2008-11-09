class SubscriberController < ApplicationController
  no_login_required
  helper_method :logged_in?
  
  def login
    if request.post?
      cookies["subscriber"] = { :value => "123", :expires => 1.hour.from_now }
    end
    render :layout => false
  end
  
  def logout
    cookies["subscriber"] = nil
    render :layout => false
  end
  
protected
  def logged_in?
    !cookies["subscriber"].blank?
  end
end
