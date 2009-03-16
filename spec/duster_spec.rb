require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::Duster do
  before do
    @duster = duster = Dust::Duster.new(BranchBadness, :branch_returning_true_or_false)
  end
  
  it "should discover each of the warning classes with the correct options" do
    warnings = [Dust::Warnings::UselessBranch, Dust::Warnings::IdenticalBranch]
    branches = [s(:true), s(:false)]
    warnings.each do |warning|
      warning.should_receive(:discover).with(branches)
    end
    
    @duster.scan_for warnings, :with => branches
  end
end
