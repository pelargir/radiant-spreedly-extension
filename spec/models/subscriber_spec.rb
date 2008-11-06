require File.dirname(__FILE__) + '/../spec_helper'

describe Subscriber do
  before(:each) do
    @subscriber = Subscriber.new
  end

  it "should be valid" do
    @subscriber.should be_valid
  end
end
