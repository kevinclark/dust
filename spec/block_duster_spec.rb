require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/block_badness'

include Fixtures

describe Dust::BlockDuster do
  it "should warn when a yield is present without a conditional" do
    duster = Dust::BlockDuster.new(BlockBadness, :no_conditional_for_block_given)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnprotectedBlock.new]
  end
  
  it "should not warn when there is a check for block_given? before yield" do
    duster = Dust::BlockDuster.new(BlockBadness, :simple_check_for_block_given)
    duster.dust!
    duster.warnings.should == []
  end
  
  it "should warn when there is a yield in a conditional without a block_given? check" do
    duster = Dust::BlockDuster.new(BlockBadness, :simple_conditional_without_check)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UnprotectedBlock.new]
  end
  
  it "should not warn when there is a check for block_given? in a complex conditional before yield" do
    duster = Dust::BlockDuster.new(BlockBadness, :complex_conditional_with_check)
    duster.dust!
    duster.warnings.should == []
  end
  
end
