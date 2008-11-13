class Admin::SpreedlyController < ApplicationController
  def edit
    if request.post?
      Radiant::Config['spreedly.api_token'] = params[:api_token]
      Radiant::Config['spreedly.login_name'] = params[:login_name]
      
      plan = SubscriptionPlan.find_by_id(params[:plan_id])
      Radiant::Config['spreedly.plan_id'] = plan.id
      Radiant::Config['spreedly.plan_name'] = plan.name
      
      Radiant::Config['spreedly.mode'] = params[:mode]
      redirect_to spreedly_index_url
    end
  end
end
