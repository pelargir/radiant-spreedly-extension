class Admin::SpreedlyController < ApplicationController
  def edit
    if request.post?
      Radiant::Config['spreedly.api_token'] = params[:api_token]
      Radiant::Config['spreedly.site_name'] = params[:site_name]
      
      plan = SubscriptionPlan.find_by_id(params[:plan_id])
      Radiant::Config['spreedly.plan_id'] = plan ? plan.id : nil
      Radiant::Config['spreedly.plan_name'] = plan ? plan.name : nil
      
      SubscriberResource.refresh
      SubscriptionPlan.refresh
      redirect_to spreedly_index_url
    end
  end
end
