require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/rescue_badness'

include Fixtures

describe Dust::Warnings::RescueValue do

  it "should match rescuing to a nil" do
    warning = Dust::Warnings::RescueValue.new(nil, [:nil])
    warning.matches?.should be_true
  end
  
  it "should match rescuing to a lit" do
    warning = Dust::Warnings::RescueValue.new(nil, [:lit, 4])
    warning.matches?.should be_true
  end
  
  it "should not match with a rescue body" do
    exp = [nil,
             [:block,
              [:call, [:lit, 4], :+, [:array, [:lit, 5]]],
              [:call, [:lit, 6], :+, [:array, [:lit, 7]]]]]
              
    warning = Dust::Warnings::RescueValue.new(*exp)
    warning.matches?.should be_false
  end
end