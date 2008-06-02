require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/rescue_badness'

include Fixtures

describe Dust::RescueDuster do
  it "should create a warning for rescuing to a value" do
    duster = Dust::RescueDuster.new(RescueBadness, :rescue_nil)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::RescueValue.new]
  end
  
  it "should create a warning for rescuing Exception" do
    duster = Dust::RescueDuster.new(RescueBadness, :rescue_exception)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::RescueEverything.new]
  end
  
  it "should create a warning for rescuing Object" do
    duster = Dust::RescueDuster.new(RescueBadness, :rescue_object)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::RescueEverything.new]
  end
   
end
