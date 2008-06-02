require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/rescue_badness'

include Fixtures

describe Dust::RescueDuster do
  it "should create a warning for rescuing to a value" do
    duster = Dust::RescueDuster.new(RescueBadness, :rescue_nil)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::RescueValue.new]
  end
end
