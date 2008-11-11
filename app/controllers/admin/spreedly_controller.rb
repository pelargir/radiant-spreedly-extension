class Admin::SpreedlyController < ApplicationController
  def index
    @spreedly_config = SpreedlyConfig.first
  end
  
  def edit
    @spreedly_config = SpreedlyConfig.first || SpreedlyConfig.new(params[:spreedly_config])
    if request.post?
      @spreedly_config.new_record? ? @spreedly_config.save! : @spreedly_config.update_attributes!(params[:spreedly_config])
      redirect_to spreedly_index_url
    end
  end
end
