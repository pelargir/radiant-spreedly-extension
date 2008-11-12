class SubscriberActionsController < ApplicationController
  no_login_required
  skip_before_filter :verify_authenticity_token
  
  def login
    if subscriber = Subscriber.authenticate(params[:email], params[:password])
      cookies["subscriber"] = { :value => subscriber.id.to_s, :expires => 1.hour.from_now }
      redirect_to "/subscriber"
    else
      flash[:notice] = "Unable to login."
      redirect_to "/subscriber/login"
    end
  end
end
