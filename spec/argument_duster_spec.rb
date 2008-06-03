require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::ArgumentDuster do
  it "should create warnings for an unreferenced argument" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :unused_arg)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnusedArgument.new(:arg)]
  end
  
  it "should not create warnings for a referenced argument" do
    duster = Dust::ArgumentDuster.new(LocalVariableBadness, :used_arg)
    duster.dust!
    duster.warnings.should == []
  end
end
