require File.dirname(__FILE__) + '/spec_helper'
require 'fixtures/branch_badness'

include Fixtures

describe Dust::Warnings::SimpleWarning do
  it "should discover a matching warning" do
    branch = mock("aUselessBranch")
    branch.should_receive(:matches?).and_return(true)
    Dust::Warnings::UselessBranch.stub!(:new).and_return(branch)
    
    Dust::Warnings::UselessBranch.discover.should == branch
  end

  it "should not discover a non-matching warning" do
    branch = mock("aUselessBranch")
    branch.should_receive(:matches?).and_return(false)
    Dust::Warnings::UselessBranch.stub!(:new).and_return(branch)
    
    Dust::Warnings::UselessBranch.discover.should be_nil
  end
end