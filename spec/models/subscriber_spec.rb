require File.dirname(__FILE__) + '/../spec_helper'

describe Subscriber do
  before(:each) do
    @subscriber = Subscriber.new(:email => "william@mckinley.com", :password => "secret")
  end

  it "should be valid" do
    @subscriber.should be_valid
  end
end
