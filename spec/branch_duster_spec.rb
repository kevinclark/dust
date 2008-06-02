require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::BranchDuster do
  it "should warn for a branch simply returning true and false" do
    # pending "working on other things"
    duster = Dust::BranchDuster.new(BranchBadness, :branch_returning_true_or_false)
    duster.dust!
    duster.warnings.should == [Dust::Warnings::UselessBranch.new]
  end
end
